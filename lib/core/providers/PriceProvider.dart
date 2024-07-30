import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class PriceProvider with ChangeNotifier {
  final FirebaseRemoteConfig remoteconfig = FirebaseRemoteConfig.instance;
  bool _showDiscountedPrice = false;

  bool get showDiscountedPrice => _showDiscountedPrice;

  PriceProvider() {
    _fetchPrices();
  }
  Future<void> _fetchPrices() async {
    try {
      remoteconfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
        await remoteconfig.fetchAndActivate();
        _showDiscountedPrice = remoteconfig.getBool('showdiscountPercentage');
        print(_showDiscountedPrice);
        notifyListeners();
      });
    } catch (e) {
      print("Failed to fetch remote config: $e");
    }
  }
}
