import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/ads_controller.dart';
import 'package:qurani_22/controllers/emotions_controller.dart';
import 'package:qurani_22/controllers/in_app_purchases_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/tabs_screen/widgets/custom_floating_bar.dart';
import 'package:qurani_22/views/tabs_screen/widgets/result_container.dart';
import 'package:qurani_22/views/tabs_screen/widgets/emotions_container.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isClicked = false;
  bool isResultShown = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
      if (isClicked) {
        setState(() {
          isClicked = false; // just close the emotions list
        });
        return false; // prevent popping the screen
      }
      return true; // allow normal back if emotions list not opened
    },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  /// Background
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/background_search.png',
                      fit: BoxFit.fill,
                    ),
                  ),
      
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isClicked ? 0 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(0.2),
                            ],
                          ),
                        ),
                        child: SizedBox(),
                      ),
                    ),
                  ),
      
                  Positioned(
                    top: isResultShown ? 40 : 60, // adjust as needed
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        // Logo
                        Image.asset(
                          'assets/images/mushaf_blue.png',
                          height: 60,
                          width: 60,
                        ),
      
                        // Title
                        Text(
                          S.of(context).talkToQuran,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
      
                        // Small paragraph
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            S.of(context).chooseYourEmotion,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  /// White Result Container
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    left: 0,
                    right: 0,
                    bottom: isClicked ? -500 : 0,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height:
                              isResultShown
                                  ? MediaQuery.of(context).size.height * 0.7
                                  : MediaQuery.of(context).size.height * 0.6,
                          child: Center(
                            child:
                                isResultShown
                                    ? const ResultContainer()
                                    : Text(
                                      S.of(context).theResultWillBeShownHere,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
      
                  /// Emotions Picker Button
                  Consumer<EmotionsController>(
                    builder: (context, emotionController, _) {
                      return AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        left: 0,
                        right: 0,
                        bottom: isClicked ? 220 : 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isClicked = !isClicked;
                              isResultShown = false;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  emotionController.selectedEmotion ??
                                      S.of(context).whatIsYourMood,
                                  style: TextStyle(
                                    color:
                                        emotionController.selectedEmotion != null
                                            ? Colors.black
                                            : Colors.grey,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (emotionController.selectedEmotion != null) {
                                      final adsController = Provider.of<AdsController>(context,listen: false);
                                      final iapProvider = Provider.of<InAppPurchasesController>(context,listen: false); 
      
                                      if (!iapProvider.isPremium) {
                                        if (adsController
                                                .isInterstitialAdLoaded &&
                                            adsController.interstitialAd !=
                                                null) {
                                          adsController.interstitialAd!.fullScreenContentCallback =
                                              FullScreenContentCallback(
                                                onAdDismissedFullScreenContent: (ad) {
                                                  emotionController.resetValues();
                                                  emotionController.fetchEmotionResult(context,emotionController.selectedEmotionId!);
                                                  setState(() {
                                                    isClicked = !isClicked;
                                                    isResultShown = !isResultShown;
                                                  });
                                                  ad.dispose();
                                                  adsController.loadInterstitialAd();
                                                },
                                              );
                                          adsController.interstitialAd!.show();
                                          adsController.interstitialAd = null;
                                          adsController.isInterstitialAdLoaded =
                                              false;
                                        } else {
                                          emotionController.resetValues();
                                          emotionController.fetchEmotionResult(
                                            context,
                                            emotionController.selectedEmotionId!,
                                          );
                                          setState(() {
                                            isClicked = !isClicked;
                                            isResultShown = !isResultShown;
                                          });
                                        }
                                      } else {
                                        emotionController.resetValues();
                                        emotionController.fetchEmotionResult(context,emotionController.selectedEmotionId!);
                                        setState(() {
                                          isClicked = !isClicked;
                                          isResultShown = !isResultShown;
                                        });
                                      }
                                    } else {
                                      showFloatingSnackBar(
                                        context,
                                        S.of(context).pleaseAddAnEmotionFirst,
                                      );
                                    }
                                  },
      
                                  borderRadius: BorderRadius.circular(100),
                                  splashColor: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [lightBlue, darkBlue],
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      
                  /// Emotions List
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    left: 0,
                    right: 0,
                    bottom: isClicked ? 0 : -250,
                    child: const EmotionsContainer(),
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 10),
            Consumer<InAppPurchasesController>(
              builder: (context, purchasesProvider, _) {
                if (purchasesProvider.isPremium) {
                  return const SizedBox();
                }
      
                return Consumer<AdsController>(
                  builder: (context, adsProvider, _) {
                    final bannerAd = adsProvider.resultBannerAd;
                    final isLoaded = adsProvider.isResultBannerAdLoaded;
      
                    if (bannerAd == null || !isLoaded) {
                      return const SizedBox();
                    }
      
                    return SizedBox(
                      width: bannerAd.size.width.toDouble(),
                      height: bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: bannerAd),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
