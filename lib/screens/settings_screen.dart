import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Settings", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
      // centerTitle: true,
      backgroundColor: const Color(0xFF2BBCE8),
      // toolbarHeight: 85,
      automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/viewProfile');
                },
                child: const Row(
                  children: [
                    Icon(Icons.person_4_outlined),
                            SizedBox(width: 5,),
                    Text("View Profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              const Divider(),
              const SizedBox(height: 5,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/aboutUs');  
                },
                child: const Row(
                  children: [
                    Icon(Icons.info_outline),
                            SizedBox(width: 10,),
                    Text("About us", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
               const SizedBox(height: 5,),
               const Divider(),
               const SizedBox(height: 5,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/logout');  
                },
                child: const Row(
                  children: [
                    Icon(Icons.exit_to_app),
                            //       Image(
                            //   image: AssetImage('assets/images/logout.png'),
                            // ),
                            SizedBox(width: 10,),
                    Text("Logout", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}