// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/ads_controller.dart';
import 'package:qurani_22/controllers/in_app_purchases_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/controllers/notifications_controller.dart';
import 'package:qurani_22/controllers/start_controller.dart';
import 'package:qurani_22/controllers/user_controller.dart';
import 'package:qurani_22/views/start/screens/start_screen.dart';
import 'package:qurani_22/views/tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnFirstTime();
  }

  Future<void> _navigateBasedOnFirstTime() async {
    Provider.of<InAppPurchasesController>(context, listen: false).initializeInAppPurchases();
    Provider.of<LangServices>(context, listen: false).loadLangFromPrefs();
    Provider.of<UserController>(context, listen: false).getOrCreateUUID();
    Provider.of<AdsController>(context, listen: false).initializeAds();
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    Future.delayed(const Duration(seconds: 3), () async {
      if (isFirstTime) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StartScreen()));
        prefs.setBool('isFirstTime', false);
      } else {
        Provider.of<StartController>(context, listen: false).getCurrentLocation(context,isFirstTime: false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TabsScreen()));
      }
   });

    NotificationsController.instance.sendFcmToBackEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Center(
        child: Image.asset(
          "assets/images/mushaf_blue.png",
        ),
      )
    );
  }
}