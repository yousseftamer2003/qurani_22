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

  /// `Here is help for your selected emotion`
  String get hereIsHelpForYourSelectedEmotion {
    return Intl.message(
      'Here is help for your selected emotion',
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

  /// `Page Form`
  String get pageForm {
    return Intl.message('Page Form', name: 'pageForm', desc: '', args: []);
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
