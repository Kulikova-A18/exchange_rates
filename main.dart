import "package:flutter/foundation.dart"
    show debugDefaultTargetPlatformOverride;
import "package:flutter/material.dart";
import 'package:exchange_rates/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:exchange_rates/models/provider.dart';
import 'package:exchange_rates/splash/splash.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(new RatesApp());
}

class RatesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RateProvider(),
      child: MaterialApp(
        theme:
            ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 17, 28, 24)),
        //home: SplashScreen(),
        home: HomeScreen(),
      ),
    );
  }
}
