import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/ads_controller.dart';
import 'package:qurani_22/controllers/emotions_controller.dart';
import 'package:qurani_22/controllers/home_controller.dart';
import 'package:qurani_22/controllers/in_app_purchases_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/controllers/start_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/tabs_screen/screens/plans_screen.dart';
import 'package:qurani_22/views/tabs_screen/widgets/custom_floating_bar.dart';
import 'package:qurani_22/views/tabs_screen/widgets/emotions_container.dart';
import 'package:qurani_22/views/tabs_screen/widgets/feautures_home_container.dart';
import 'package:qurani_22/views/tabs_screen/widgets/prayer_count.dart';
import 'package:qurani_22/views/tabs_screen/widgets/prayer_times_container.dart';
import 'package:qurani_22/views/tabs_screen/widgets/result_container.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isClicked = false;
  bool isResultShown = false;

  @override
  void initState() {
    Provider.of<HomeController>(context, listen: false).getPrayerTimes(context);
    Provider.of<InAppPurchasesController>(context, listen: false).initialize();
    Provider.of<EmotionsController>(context, listen: false).getEmotions(context);
    Provider.of<EmotionsController>(context, listen: false).getEmotionsLimit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langServices = Provider.of<LangServices>(context,listen: false);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/background_search.png',
                    fit: BoxFit.fill,
                  ),
                ),

                PrayerCount(
                  isClicked: isClicked,
                  isResultShown: isResultShown,
                ),

                if (!isClicked)
                  Positioned(
                      top: 10,
                      left: 20,
                      child: Consumer<LangServices>(
                        builder: (context, langProvider, _) {
                          return OutlinedButton(
                          onPressed: () {
                            if(langProvider.selectedLang == 'en'){
                              langServices.selectLang('ar');
                            }else{
                              langServices.selectLang('en');
                            }
                          },
                          child: Text(
                              langProvider.selectedLang == 'en' ? 'العربية' : 'English',
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ); 
                        },
                      )),

                if (!isClicked)
                  Positioned(
                    top: 28,
                    right: 20,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const PlansScreen()));
                        },
                        child: SvgPicture.asset(
                          'assets/images/prem_user.svg',
                          width: 100,
                        )),
                  ),

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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: isResultShown
                            ? MediaQuery.of(context).size.height * 0.67
                            : MediaQuery.of(context).size.height * 0.6,
                        child: Column(
                          children: [
                            Consumer2<StartController, HomeController>(
                              builder:
                                  (context, startProvider, homeProvider, _) {
                                if (!homeProvider.isLoaded) {
                                  return const Center(
                                    child: CircularProgressIndicator(color: darkBlue),
                                  );
                                } else {
                                  var monthName = langServices.isArabic? homeProvider.hijriDate!.monthNameAr :  homeProvider.hijriDate!.monthNameEn;
                                  final address = startProvider.address;
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(address,
                                                overflow: TextOverflow.ellipsis)),
                                        const SizedBox(width: 80),
                                        Text("$monthName ${homeProvider.hijriDate!.day}, ${homeProvider.hijriDate!.year} "),
                                        Text(homeProvider.hijriDate!.yearAbbreviated),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            const PrayerTimesContainer(),
                            const FeauturesHomeContainer(),
                            isResultShown
                                ? const ResultContainer()
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Center(
                                        child: Text(
                                            S.of(context).theResultWillBeShownHere,),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// Animated Emotion Picker Button
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
                              horizontal: 15, vertical: 15),
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
                                    color: emotionController.selectedEmotion !=
                                            null
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                              InkWell(
                                onTap: (){
                                  if (emotionController.selectedEmotion !=null) {
                                    final adsController = Provider.of<AdsController>(context,listen: false);

                                    if (adsController.isInterstitialAdLoaded &&adsController.interstitialAd != null) {
                                      adsController.interstitialAd!.fullScreenContentCallback =
                                          FullScreenContentCallback(
                                        onAdDismissedFullScreenContent:
                                            (InterstitialAd ad) {
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
                                          emotionController.selectedEmotionId!);
                                      setState(() {
                                        isClicked = !isClicked;
                                        isResultShown = !isResultShown;
                                      });
                                    }
                                  } else {
                                    showFloatingSnackBar(context,S.of(context).pleaseAddAnEmotionFirst);
                                  }
                                },
                                borderRadius: BorderRadius.circular(100),
                                splashColor: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [
                                      lightBlue,
                                      darkBlue,
                                      ]),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.arrow_upward, color: Colors.white),
                                        ),
                                        ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                  final bannerAd = adsProvider.bannerAd;
                  if (bannerAd == null) {
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
