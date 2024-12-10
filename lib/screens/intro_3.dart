import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro3 extends StatefulWidget {
  const Intro3({super.key});

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80,),
            Lottie.asset("assets/images/map.json", height: 300, width: 300),
            const SizedBox(
              height: 0,
            ),
            const Text(
              "Clock In with Location Accuracy!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Enable location tracking to confirm your"),
            const Text('worksite. We respect your privacy and only'),
            const Text('track during clock-ins and clock-outs.'),
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Container(
                decoration: BoxDecoration(
                  color:  const Color(0xFF2BBCE8),
                  borderRadius: BorderRadius.circular(7)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Get started", style: TextStyle(color: Colors.white, fontSize: 15),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
