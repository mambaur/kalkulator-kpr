import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalkulator_kpr/blocs/purchase_cubit/purchase_cubit.dart';
import 'package:kalkulator_kpr/pages/home/home_screen.dart';
import 'package:upgrader/upgrader.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PurchaseCubit()..checkPremium(),
        ),
      ],
      child: MaterialApp(
        title: 'Kalkulator KPR',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: UpgradeAlert(
            showIgnore: false,
            showLater: false,
            canDismissDialog: false,
            showReleaseNotes: false,
            upgrader: Upgrader(
              durationUntilAlertAgain: const Duration(hours: 3),
            ),
            child: const MyHomePage(title: 'Kalkulator KPR')),
      ),
    );
  }
}
