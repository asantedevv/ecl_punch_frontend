

import 'package:ecl_punchin/modules/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  User? user;
  String fullName = '';
  String jobTitle = '';
  String mobilePhone = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  Future<void> loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? 'N/A';
      jobTitle = prefs.getString('jobTitle') ?? 'N/A';
      mobilePhone = prefs.getString('mobilePhone') ?? 'N/A';
      email = prefs.getString('email') ?? 'N/A';
    });
    Logger().d("User details loaded");
  }

  Future<void> saveUserDetails(String fullName, String jobTitle,
      String mobilePhone, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('fullName', fullName);
    await prefs.setString('jobTitle', jobTitle);
    await prefs.setString('mobilePhone', mobilePhone);
    await prefs.setString('email', email);

    Logger().d("User details saved");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "View Profile",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2BBCE8),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.person_4_outlined),
                  const SizedBox(width: 20),
                  Text(
                    fullName,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.work_outline),
                  const SizedBox(width: 20),
                  Text(
                    jobTitle,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.phone_outlined),
                  const SizedBox(width: 20),
                  Text(
                    mobilePhone,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.email_outlined),
                  const SizedBox(width: 20),
                  Text(
                    email,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
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



// import 'package:ecl_punchin/modules/auth/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ViewProfile extends StatefulWidget {
//   const ViewProfile({super.key});

//   @override
//   State<ViewProfile> createState() => _ViewProfileState();
// }

// class _ViewProfileState extends State<ViewProfile> {
//   User? user;

//   Future<void> saveUserDetails(String fullName, String jobTitle,
//       String mobilePhone, String email) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     await prefs.setString('fullName', fullName);
//     await prefs.setString('jobTitle', jobTitle);
//     await prefs.setString('mobilePhone', mobilePhone);
//     await prefs.setString('email', email);

//     Logger().d("user details saved");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           "View Profile",
//           style: TextStyle(
//               fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         // centerTitle: true,
//         backgroundColor: const Color(0xFF2BBCE8),
//         // toolbarHeight: 85,
//         automaticallyImplyLeading: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   const Icon(Icons.person_4_outlined),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     user!.fullName,
//                     style: const TextStyle(
//                         fontSize: 15, fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               const Divider(),
//               const SizedBox(
//                 height: 5,
//               ),
//               const Row(
//                 children: [
//                   Icon(Icons.work_outline),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     "Job Title",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               const Divider(),
//               const SizedBox(
//                 height: 5,
//               ),
//               const Row(
//                 children: [
//                   Icon(Icons.phone_outlined),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     "Phone Number",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               const Divider(),
//               const SizedBox(
//                 height: 5,
//               ),
//               const Row(
//                 children: [
//                   Icon(Icons.email_outlined),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     "Email Address",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }