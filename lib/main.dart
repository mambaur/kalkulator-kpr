import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalkulator_kpr/app.dart';
import 'package:kalkulator_kpr/core/purchases.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  Purchase purchase = Purchase();
  await purchase.initPlatformState();

  runApp(const MyApp());
}
