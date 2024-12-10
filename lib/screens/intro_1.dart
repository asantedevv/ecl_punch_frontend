import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/clock-in.json",
                height: 300, width: 300),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Punch In and Out in Seconds!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Start your shift by punching in and end it"),
            const Text(' by punching out—all with a tap. Your'),
            const Text('workday, simplified.'),
          ],
        ),
      ),
    );
  }
}
