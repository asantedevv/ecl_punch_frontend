import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {


Future<void> saveUserDetails(String fullName, String jobTitle, String mobilePhone, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('fullName', fullName);
  await prefs.setString('jobTitle', jobTitle);
  await prefs.setString('mobilePhone', mobilePhone);
  await prefs.setString('email', email);

  Logger().d("user details saved");

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("View Profile", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
      // centerTitle: true,
      backgroundColor: const Color(0xFF2BBCE8),
      // toolbarHeight: 85,
      automaticallyImplyLeading: true,),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.person_4_outlined),
            SizedBox(width: 20,),
                  Text("Full Name", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(Icons.work_outline),
            SizedBox(width: 20,),
                  Text("Job Title", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(Icons.phone_outlined),
            SizedBox(width: 20,),
                  Text("Phone Number", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(Icons.email_outlined),
            SizedBox(width: 20,),
                  Text("Email Address", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}