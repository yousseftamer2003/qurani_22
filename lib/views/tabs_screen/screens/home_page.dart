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
import 'package:qurani_22/views/tabs_screen/screens/plans_screen.dart';
import 'package:qurani_22/views/tabs_screen/widgets/feautures_home_container.dart';
import 'package:qurani_22/views/tabs_screen/widgets/prayer_count.dart';
import 'package:qurani_22/views/tabs_screen/widgets/prayer_times_container.dart';
import 'package:qurani_22/views/tabs_screen/widgets/talk_to_quran_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  bool isClicked = false;
  bool isResultShown = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<EmotionsController>(context,listen: false,).getEmotions(context);
    Provider.of<EmotionsController>(context,listen: false,).getEmotionsLimit(context);
    Provider.of<HomeController>(context, listen: false).getPrayerTimes(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langServices = Provider.of<LangServices>(context, listen: false);
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

                PrayerCount(isClicked: isClicked, isResultShown: isResultShown),

                if (!isClicked)
                  Positioned(
                    top: 10,
                    left: 20,
                    child: Consumer<LangServices>(
                      builder: (context, langProvider, _) {
                        return OutlinedButton(
                          onPressed: () {
                            if (langProvider.selectedLang == 'en') {
                              langServices.selectLang('ar');
                            } else {
                              langServices.selectLang('en');
                            }
                          },
                          child: Text(
                            langProvider.selectedLang == 'en'
                                ? 'العربية'
                                : 'English',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),

                if (!isClicked)
                  Positioned(
                    top: 12,
                    right: 8,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const PlansScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset('assets/images/prem_user.svg',width: 100)),
                    
                  ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
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
                        height: MediaQuery.of(context).size.height * 0.51,
                        child: Column(
                          children: [
                            Consumer2<StartController, HomeController>(
                              builder: (context,startProvider,homeProvider,_) {
                                if (!homeProvider.isLoaded) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: darkBlue,
                                    ),
                                  );
                                } else {
                                  var monthName =
                                      langServices.isArabic
                                          ? homeProvider.hijriDate!.monthNameAr
                                          : homeProvider.hijriDate!.monthNameEn;
                                  final address = startProvider.address;
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            address,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 80),
                                        Text(
                                          "$monthName ${homeProvider.hijriDate!.day}, ${homeProvider.hijriDate!.year} ",
                                        ),
                                        Text(
                                          homeProvider
                                              .hijriDate!
                                              .yearAbbreviated,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            const PrayerTimesContainer(),
                            const FeauturesHomeContainer(),
                            const Spacer(),
                            TalkToQuranButton(),
                            const SizedBox(height: 60,)
                          ],
                        ),
                      ),
                    ),
                  ),
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
                  final isLoaded = adsProvider.isAdLoaded;

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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
