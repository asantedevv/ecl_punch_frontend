import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro2 extends StatefulWidget {
  const Intro2({super.key});

  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/selfie.json", height: 300, width: 300),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Add Photo Proof To Your Record!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Snap a quick photo when you punch in or "),
            const Text('out to ensure accuracy and accountability.'),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
