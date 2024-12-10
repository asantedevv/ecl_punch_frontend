import 'package:ecl_punchin/modules/auth/screens/login_screen.dart';
import 'package:ecl_punchin/screens/about_us_screen.dart';
import 'package:ecl_punchin/screens/main_screen.dart';
import 'package:ecl_punchin/screens/punch_in_screen.dart';
import 'package:ecl_punchin/screens/punch_out_screen.dart';
import 'package:ecl_punchin/screens/settings_screen.dart';
import 'package:ecl_punchin/screens/splash_screen.dart';
import 'package:ecl_punchin/screens/time_card_screen.dart';
import 'package:ecl_punchin/screens/view_profile_screen.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Intro',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/punch-in': (context) => const PunchIn(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/punch-out': (context) => const PunchOut(),
        '/logout': (context) => const LoginScreen(),
        '/main-screen': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
        '/viewProfile': (context) => const ViewProfile(),
        '/aboutUs': (context) => const AboutUs(),




      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
