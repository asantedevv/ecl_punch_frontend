import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("About Us", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
      // centerTitle: true,
      backgroundColor: const Color(0xFF2BBCE8),
      // toolbarHeight: 85,
      automaticallyImplyLeading: true,),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("About ECL Punch", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text("Introducing ECL Punch, a user-friendly and secure mobile app built specifically for the employees of Enterprise Computing Limited. ECL Punch is designed to streamline your workday, offering an effortless way to punch in and out with just a tap."),
              SizedBox(height: 15,),
              Divider(),
              SizedBox(height: 15,),
              Text("Our Mission", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text("At Enterprise Computing Limited, we’re dedicated to using technology to improve the work experience. Our mission is to foster a transparent and efficient environment for our team. With ECL Punch, we aim to simplify time tracking, helping everyone stay organized and ensuring smooth, accurate record-keeping."),
              SizedBox(height: 15,),
              Divider(),
              SizedBox(height: 15,),
              Text("Key Features", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Row(
                children: [
                  Column(
                    children: [
                      Text("1. Easy punch-in and punch-out functionality with just a tap. \n2. Notifications and reminders to keep you on track. \n3. GPS-based check-in to ensure accuracy."),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}