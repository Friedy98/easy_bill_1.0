// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../BillPage/BillWithMeter.dart';
import '../../BillPage/BillWithoutMeter.dart';
import '../../Home/FormWithoutMeter.dart';
import '../../Home/FormWithMeter.dart';
import '../../Home/mainHome.dart';
import '../../main.dart';

class AppConstants {
  static Map<String, Widget Function(dynamic)> appRoutes = {
    '/': (_) => MyApp(),
    HomePage.routeName: (_) =>  const HomePage(),
    BillPage.routeName: (_) => const BillPage(),
    MainHome.routeName: (_) => const MainHome(),
    WithoutMeter.routeName: (_) => const WithoutMeter(),
    BillWithoutMeter.routeName: (_) => const BillWithoutMeter()
  };

  static setSystemStyling() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  static const privacyPolicyTxt =
      'Give your E-Commerce app an outstanding look.It\'s a small but attractive and beautiful design template for your E-Commerce App.Contact us for more amazing and outstanding designs for your apps.Do share this app with your Friends and rate us if you like this.Also check your other apps';
}
