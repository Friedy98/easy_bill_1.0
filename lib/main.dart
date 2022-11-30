
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled1/utils/Constants/app_constants.dart';
import 'package:untitled1/utils/app_theme.dart';
import 'Home/mainHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConstants.setSystemStyling();
  runApp(
    ScreenUtilInit(
      builder: (BuildContext context,child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routes: AppConstants.appRoutes,
        initialRoute: '/',
      ),
      designSize: const Size(375, 812),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    // TODO: implement initState

    super.initState();
  }

  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen.withScreenFunction(
      splash: Image.asset('assets/images/logofikish.jpg'),
      duration: 5000,
      splashIconSize: double.infinity,
      screenFunction: () async{
        return const MainHome();
      },
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      //pageTransitionType: PageTransitionType.scale,
    );
  }
}