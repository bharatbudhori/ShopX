import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';

  static String get interstitialAdUnitId => Platform.isAndroid
      ? '	ca-app-pub-3940256099942544/1033173712'
      : '	ca-app-pub-3940256099942544/1033173712';

  InterstitialAd _interstitialAd;
  int numberOfAttemptLoad = 0;

  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
      size: AdSize.largeBanner,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(
        onAdClosed: (Ad ad) => print('Ad closed'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened'),
        onAdLoaded: (Ad ad) => print('Add lodded'),
      ),
      request: AdRequest(),
    );
    return ad;
  }

  void createInterad() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        _interstitialAd = ad;
        numberOfAttemptLoad = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        numberOfAttemptLoad++;
        _interstitialAd = null;
        if (numberOfAttemptLoad <= 2) {
          createInterad();
        }
      }),
    );
  }

// show interstitial ads to user
  void showInterad() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      print("ad onAdshowedFullscreen");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("ad Disposed");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
      print('$ad OnAdFailed $aderror');
      ad.dispose();
      createInterad();
    });
    _interstitialAd.show();
    _interstitialAd = null;
  }
}
