import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController with ChangeNotifier {
  BannerAd? _bannerAd;
  InterstitialAd? interstitialAd;
  bool isInterstitialAdLoaded = false;

  /// Getter for Banner Ad
  BannerAd? get bannerAd => _bannerAd;
  
  /// Initialize Ads SDK
  Future<void> initializeAds() async {
    await MobileAds.instance.initialize();
    loadBannerAd();
    loadInterstitialAd();
  }

  /// Load Banner Ad
  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Platform.isIOS? 'ca-app-pub-3863114333197264/8897758339' : 'ca-app-pub-3863114333197264/9220357819',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  /// Load Interstitial Ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isIOS? 'ca-app-pub-3863114333197264/9569177333' : 'ca-app-pub-3863114333197264/1067870786',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          isInterstitialAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
          isInterstitialAdLoaded = false;
        },
      ),
    );
  }

  /// Show Interstitial Ad
  void showInterstitialAd() {
    if (isInterstitialAdLoaded && interstitialAd != null) {
      interstitialAd!.show();
      interstitialAd = null;
      isInterstitialAdLoaded = false;
      loadInterstitialAd(); // Load a new ad after showing
    } else {
      debugPrint('InterstitialAd not loaded yet');
    }
  }

  /// Dispose Ads
  @override
  void dispose() {
    _bannerAd?.dispose();
    interstitialAd?.dispose();
    super.dispose();
  }
}
