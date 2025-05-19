import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/controllers/ads_controller.dart';
import 'package:qurani_22/controllers/azkar_controller.dart';
import 'package:qurani_22/controllers/duaa_controller.dart';
import 'package:qurani_22/controllers/emotions_controller.dart';
import 'package:qurani_22/controllers/for_you_page_controller.dart';
import 'package:qurani_22/controllers/home_controller.dart';
import 'package:qurani_22/controllers/in_app_purchases_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/controllers/notifications_controller.dart';
import 'package:qurani_22/controllers/qiblah_controller.dart';
import 'package:qurani_22/controllers/sebha_controller.dart';
import 'package:qurani_22/controllers/start_controller.dart';
import 'package:qurani_22/controllers/user_controller.dart';
import 'package:qurani_22/firebase_options.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/controllers/quran_provider.dart';
import 'package:qurani_22/views/start/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await NotificationsController.instance.initialize();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StartController()),
        ChangeNotifierProvider(create: (_) => QuranController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => QiblaProvider()),
        ChangeNotifierProvider(create: (_) => SebhaController()),
        ChangeNotifierProvider(create: (_) => QuranNavigationController()),
        ChangeNotifierProvider(create: (_) => LangServices()),
        ChangeNotifierProvider(create: (_) => InAppPurchasesController()),
        ChangeNotifierProvider(create: (_) => AdsController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => DuaaController()),
        ChangeNotifierProvider(create: (_) => EmotionsController()),
        ChangeNotifierProvider(create: (_) => AzkarController()),
        ChangeNotifierProvider(create: (_) => ForYouPageController()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => 
        Consumer<LangServices>(
          builder: (context, langServices, _) {
            return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
            locale: Locale(langServices.selectedLang),
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: false,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
              )
            ),
            home: const SplashScreen()
          );
          },
        )
      ),
    );
  }
}
