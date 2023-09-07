import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Purchase {
  final String _apiPublicKey = 'goog_TxHpvzIsxQmjdMVokLRhsiMObAV';

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration;
    configuration = PurchasesConfiguration(_apiPublicKey);
    await Purchases.configure(configuration);
  }

  Future<List<Offering>> getOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      Offering? offering = offerings.current;
      return offering != null ? [offering] : [];
    } on PlatformException catch (e) {
      if (kDebugMode) print(e.toString());
      return [];
    }
  }

  Future<List<Package>> getPackages() async {
    List<Offering> offerings = await getOfferings();
    if (offerings.isEmpty) {
      return [];
    } else {
      List<Package> packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();
      return packages;
    }
  }
}
