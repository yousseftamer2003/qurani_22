// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Languages`
  String get languages {
    return Intl.message('Languages', name: 'languages', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Choose Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Welcome to Talk to Quran`
  String get welcometoTalktoQuran {
    return Intl.message(
      'Welcome to Talk to Quran',
      name: 'welcometoTalktoQuran',
      desc: '',
      args: [],
    );
  }

  /// `Lang`
  String get lang {
    return Intl.message('Lang', name: 'lang', desc: '', args: []);
  }

  /// `The Result will be shown here!`
  String get theResultWillBeShownHere {
    return Intl.message(
      'The Result will be shown here!',
      name: 'theResultWillBeShownHere',
      desc: '',
      args: [],
    );
  }

  /// `What is your mood?`
  String get whatIsYourMood {
    return Intl.message(
      'What is your mood?',
      name: 'whatIsYourMood',
      desc: '',
      args: [],
    );
  }

  /// `Please add an emotion first!`
  String get pleaseAddAnEmotionFirst {
    return Intl.message(
      'Please add an emotion first!',
      name: 'pleaseAddAnEmotionFirst',
      desc: '',
      args: [],
    );
  }

  /// `Time left until prayer`
  String get timeUntilNextPrayer {
    return Intl.message(
      'Time left until prayer',
      name: 'timeUntilNextPrayer',
      desc: '',
      args: [],
    );
  }

  /// `Next Prayer:`
  String get nextPrayer {
    return Intl.message('Next Prayer:', name: 'nextPrayer', desc: '', args: []);
  }

  /// `Fajr`
  String get fajr {
    return Intl.message('Fajr', name: 'fajr', desc: '', args: []);
  }

  /// `Dhuhr`
  String get dhuhr {
    return Intl.message('Dhuhr', name: 'dhuhr', desc: '', args: []);
  }

  /// `Asr`
  String get asr {
    return Intl.message('Asr', name: 'asr', desc: '', args: []);
  }

  /// `Maghrib`
  String get maghrib {
    return Intl.message('Maghrib', name: 'maghrib', desc: '', args: []);
  }

  /// `Isha`
  String get isha {
    return Intl.message('Isha', name: 'isha', desc: '', args: []);
  }

  /// `Shurooq`
  String get Shurooq {
    return Intl.message('Shurooq', name: 'Shurooq', desc: '', args: []);
  }

  /// `Sebha`
  String get sebha {
    return Intl.message('Sebha', name: 'sebha', desc: '', args: []);
  }

  /// `Azkar`
  String get Azkar {
    return Intl.message('Azkar', name: 'Azkar', desc: '', args: []);
  }

  /// `Doaa`
  String get Doaa {
    return Intl.message('Doaa', name: 'Doaa', desc: '', args: []);
  }

  /// `Share as Text`
  String get shareAsText {
    return Intl.message(
      'Share as Text',
      name: 'shareAsText',
      desc: '',
      args: [],
    );
  }

  /// `Share as Screenshot`
  String get shareAsScreenshot {
    return Intl.message(
      'Share as Screenshot',
      name: 'shareAsScreenshot',
      desc: '',
      args: [],
    );
  }

  /// `Here’s some comfort for what you’re going through.`
  String get hereIsHelpForYourSelectedEmotion {
    return Intl.message(
      'Here’s some comfort for what you’re going through.',
      name: 'hereIsHelpForYourSelectedEmotion',
      desc: '',
      args: [],
    );
  }

  /// `Regenerate`
  String get Regenerate {
    return Intl.message('Regenerate', name: 'Regenerate', desc: '', args: []);
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Mushaf`
  String get Mushaf {
    return Intl.message('Mushaf', name: 'Mushaf', desc: '', args: []);
  }

  /// `No Saved Page`
  String get NoSavedPage {
    return Intl.message(
      'No Saved Page',
      name: 'NoSavedPage',
      desc: '',
      args: [],
    );
  }

  /// `Go to Saved Page`
  String get GoToSavedPage {
    return Intl.message(
      'Go to Saved Page',
      name: 'GoToSavedPage',
      desc: '',
      args: [],
    );
  }

  /// `Verse`
  String get verse {
    return Intl.message('Verse', name: 'verse', desc: '', args: []);
  }

  /// `Goto`
  String get Goto {
    return Intl.message('Goto', name: 'Goto', desc: '', args: []);
  }

  /// `Surah`
  String get surah {
    return Intl.message('Surah', name: 'surah', desc: '', args: []);
  }

  /// `Go`
  String get go {
    return Intl.message('Go', name: 'go', desc: '', args: []);
  }

  /// `Hold verse to listen`
  String get holdVerseToListen {
    return Intl.message(
      'Hold verse to listen',
      name: 'holdVerseToListen',
      desc: '',
      args: [],
    );
  }

  /// `Save Page`
  String get savePage {
    return Intl.message('Save Page', name: 'savePage', desc: '', args: []);
  }

  /// `Tafsir`
  String get pageForm {
    return Intl.message('Tafsir', name: 'pageForm', desc: '', args: []);
  }

  /// `Listen to Quran`
  String get listenToQuran {
    return Intl.message(
      'Listen to Quran',
      name: 'listenToQuran',
      desc: '',
      args: [],
    );
  }

  /// `Juz`
  String get juz {
    return Intl.message('Juz', name: 'juz', desc: '', args: []);
  }

  /// `Page`
  String get page {
    return Intl.message('Page', name: 'page', desc: '', args: []);
  }

  /// `Today's Feed:`
  String get todaysFeed {
    return Intl.message(
      'Today\'s Feed:',
      name: 'todaysFeed',
      desc: '',
      args: [],
    );
  }

  /// `Click here to count`
  String get clickHereToCount {
    return Intl.message(
      'Click here to count',
      name: 'clickHereToCount',
      desc: '',
      args: [],
    );
  }

  /// `Today's Duaa`
  String get todaysduaa {
    return Intl.message(
      'Today\'s Duaa',
      name: 'todaysduaa',
      desc: '',
      args: [],
    );
  }

  /// `Count for Zekr`
  String get countForZekr {
    return Intl.message(
      'Count for Zekr',
      name: 'countForZekr',
      desc: '',
      args: [],
    );
  }

  /// `Your phone may block Azan notifications in the background.`
  String get yourPhoneMayBlockAzanNotificationsInBackground {
    return Intl.message(
      'Your phone may block Azan notifications in the background.',
      name: 'yourPhoneMayBlockAzanNotificationsInBackground',
      desc: '',
      args: [],
    );
  }

  /// `Please allow auto-start for this app.`
  String get pleaseAllowAutoStartForThisApp {
    return Intl.message(
      'Please allow auto-start for this app.',
      name: 'pleaseAllowAutoStartForThisApp',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Continue your last read`
  String get continueUrLastRead {
    return Intl.message(
      'Continue your last read',
      name: 'continueUrLastRead',
      desc: '',
      args: [],
    );
  }

  /// `Talk to Quran`
  String get talkToQuran {
    return Intl.message(
      'Talk to Quran',
      name: 'talkToQuran',
      desc: '',
      args: [],
    );
  }

  /// `Choose your emotion and we will get you an Aya or Duaa to help you get through it.`
  String get chooseYourEmotion {
    return Intl.message(
      'Choose your emotion and we will get you an Aya or Duaa to help you get through it.',
      name: 'chooseYourEmotion',
      desc: '',
      args: [],
    );
  }

  /// `Address is required`
  String get addressRequired {
    return Intl.message(
      'Address is required',
      name: 'addressRequired',
      desc: '',
      args: [],
    );
  }

  /// `To get your location and continue`
  String get toGetYourLocationAndContinue {
    return Intl.message(
      'To get your location and continue',
      name: 'toGetYourLocationAndContinue',
      desc: '',
      args: [],
    );
  }

  /// `Click on`
  String get clickOn {
    return Intl.message('Click on', name: 'clickOn', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Location Required`
  String get locationRequired {
    return Intl.message(
      'Location Required',
      name: 'locationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enable location services for exact prayer times.`
  String get pleaseEnableLocationServicesForExactPrayerTimes {
    return Intl.message(
      'Please enable location services for exact prayer times.',
      name: 'pleaseEnableLocationServicesForExactPrayerTimes',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Go Premium and unlock everything:`
  String get UnlockPremium {
    return Intl.message(
      'Go Premium and unlock everything:',
      name: 'UnlockPremium',
      desc: '',
      args: [],
    );
  }

  /// `Full Quran with no ads`
  String get NoAds {
    return Intl.message(
      'Full Quran with no ads',
      name: 'NoAds',
      desc: '',
      args: [],
    );
  }

  /// `Chat with the Quran anytime, with no limits`
  String get noGenerationLimits {
    return Intl.message(
      'Chat with the Quran anytime, with no limits',
      name: 'noGenerationLimits',
      desc: '',
      args: [],
    );
  }

  /// `Pick your plan`
  String get pickUrPlan {
    return Intl.message(
      'Pick your plan',
      name: 'pickUrPlan',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Premium`
  String get upgradeToPremium {
    return Intl.message(
      'Upgrade to Premium',
      name: 'upgradeToPremium',
      desc: '',
      args: [],
    );
  }

  /// `Restore Purchases`
  String get restorePurchases {
    return Intl.message(
      'Restore Purchases',
      name: 'restorePurchases',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message('month', name: 'month', desc: '', args: []);
  }

  /// `year`
  String get year {
    return Intl.message('year', name: 'year', desc: '', args: []);
  }

  /// `Quran chat is not just quran reader. its spiritual experience that makes you feel like the Quran is speaking directly to you.`
  String get onboardingText {
    return Intl.message(
      'Quran chat is not just quran reader. its spiritual experience that makes you feel like the Quran is speaking directly to you.',
      name: 'onboardingText',
      desc: '',
      args: [],
    );
  }

  /// `Quran Chat`
  String get Qurancaht {
    return Intl.message('Quran Chat', name: 'Qurancaht', desc: '', args: []);
  }

  /// `Where the Quran speaks to your heart`
  String get WheretheQuranspeakstoyourheart {
    return Intl.message(
      'Where the Quran speaks to your heart',
      name: 'WheretheQuranspeakstoyourheart',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get GetStarted {
    return Intl.message('Get Started', name: 'GetStarted', desc: '', args: []);
  }

  /// `Smart Tasbih to track your dhikr`
  String get SmartTasbihtotrackyourdhikr {
    return Intl.message(
      'Smart Tasbih to track your dhikr',
      name: 'SmartTasbihtotrackyourdhikr',
      desc: '',
      args: [],
    );
  }

  /// `Personalized Duas for your feelings`
  String get PersonalizedDuasforyourfeelings {
    return Intl.message(
      'Personalized Duas for your feelings',
      name: 'PersonalizedDuasforyourfeelings',
      desc: '',
      args: [],
    );
  }

  /// `Faster experience and exclusive updates`
  String get Fasterexperienceandexclusiveupdates {
    return Intl.message(
      'Faster experience and exclusive updates',
      name: 'Fasterexperienceandexclusiveupdates',
      desc: '',
      args: [],
    );
  }

  /// `Your heart deserves the full experience.`
  String get Yourheartdeservesthefullexperience {
    return Intl.message(
      'Your heart deserves the full experience.',
      name: 'Yourheartdeservesthefullexperience',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe now and feel the difference.`
  String get Subscribenowandfeelthedifference {
    return Intl.message(
      'Subscribe now and feel the difference.',
      name: 'Subscribenowandfeelthedifference',
      desc: '',
      args: [],
    );
  }

  /// `Get Pro`
  String get getPro {
    return Intl.message('Get Pro', name: 'getPro', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Quran`
  String get Quran {
    return Intl.message('Quran', name: 'Quran', desc: '', args: []);
  }

  /// `For You`
  String get ForYou {
    return Intl.message('For You', name: 'ForYou', desc: '', args: []);
  }

  /// `Listen to verse`
  String get listenToVerse {
    return Intl.message(
      'Listen to verse',
      name: 'listenToVerse',
      desc: '',
      args: [],
    );
  }

  /// `Page`
  String get Page {
    return Intl.message('Page', name: 'Page', desc: '', args: []);
  }

  /// `saved successfully!`
  String get savedSuccessfully {
    return Intl.message(
      'saved successfully!',
      name: 'savedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message('Next', name: 'Next', desc: '', args: []);
  }

  /// `Why We Need Location?`
  String get WhyWeNeedLocation {
    return Intl.message(
      'Why We Need Location?',
      name: 'WhyWeNeedLocation',
      desc: '',
      args: [],
    );
  }

  /// `To get to you exact prayer time and have the full experience with us.`
  String get ToGetToYouExactPrayerTimeAndHaveTheFullExperienceWithUs {
    return Intl.message(
      'To get to you exact prayer time and have the full experience with us.',
      name: 'ToGetToYouExactPrayerTimeAndHaveTheFullExperienceWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Start Now!`
  String get startNow {
    return Intl.message('Start Now!', name: 'startNow', desc: '', args: []);
  }

  /// `Normal View`
  String get normalView {
    return Intl.message('Normal View', name: 'normalView', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Permission Denied`
  String get permissionDenied {
    return Intl.message(
      'Permission Denied',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Location permission permanently denied.`
  String get locationPermissionPermanentlyDenied {
    return Intl.message(
      'Location permission permanently denied.',
      name: 'locationPermissionPermanentlyDenied',
      desc: '',
      args: [],
    );
  }

  /// `You have reached the limit of generations today`
  String get generationLimit {
    return Intl.message(
      'You have reached the limit of generations today',
      name: 'generationLimit',
      desc: '',
      args: [],
    );
  }

  /// `Please come back tommorrow`
  String get pleaseComeBackTommorrow {
    return Intl.message(
      'Please come back tommorrow',
      name: 'pleaseComeBackTommorrow',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
