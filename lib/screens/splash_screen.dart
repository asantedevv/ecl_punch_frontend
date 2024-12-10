import 'dart:async';

import 'package:ecl_punchin/modules/auth/screens/login_screen.dart';
import 'package:ecl_punchin/screens/main_screen.dart';
import 'package:ecl_punchin/screens/onboarding_screens.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    timer();
    super.initState();
  }

  void timer() {
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OnboardingScreens()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/ee.png'),
            ),
          ],
        ),
      ),
    );
  }
}
