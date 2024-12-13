// Mine

// import 'dart:convert';

// import 'package:ecl_punchin/modules/auth/models/punch_details_card.dart';
// import 'package:ecl_punchin/modules/auth/models/punch_model.dart';
// import 'package:ecl_punchin/modules/auth/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:logger/logger.dart';

// class TimeCard extends StatefulWidget {
//   const TimeCard({super.key});

//   @override
//   State<TimeCard> createState() => _TimeCardState();
// }

// class _TimeCardState extends State<TimeCard> {
//   User? user;
//   List<PunchModel> punches = [];

//   Future<bool> findPunchCardById(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? userId = prefs.getInt('userId');
//     String? foundToken = prefs.getString('token');

//     var uri = Uri.parse(
//         "https://a7d1-196-61-37-18.ngrok-free.app/api/v1/punchcard/find-by-userId/$userId");

//     Map<String, String> header = {
//       "Content-Type": "application/json",
//       "Authorization": foundToken ?? "",
//       "Accept": "application/json"
//     };

//     Logger().d("Finding punch cards is here");

//     Logger().d(uri);
//     Logger().d(header.entries);

//     var response = await http.post(uri, headers: header);

//     List jsonResponse = jsonDecode(response.body);

//     setState(() {
//       punches =
//           jsonResponse.map((punch) => PunchModel.fromJson(punch)).toList();
//     });

//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         title: const Text("Lobace Food"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Popular Dishes",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: punches.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: PunchDetailsCard(
//                       punchDate: punches[index].punchDate,
//                       punchInTime: punches[index].punchInDateTime,
//                       punchOutTime: punches[index].punchOutDateTime,
//                       totalHours: punches[index].totalHours,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/orderSummary');
//         },
//         backgroundColor: Colors.deepPurple,
//         child: const Icon(Icons.shopping_cart, color: Colors.white),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:ecl_punchin/modules/auth/models/punch_details_card.dart';
import 'package:ecl_punchin/modules/auth/models/punch_model.dart';
import 'package:ecl_punchin/modules/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class TimeCard extends StatefulWidget {
  const TimeCard({super.key});

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  void initState() {
    findPunchCardById(context);
    // retrieveUserById();

    // TODO: implement initState
    super.initState();
  }

  User? user;
  List<PunchModel> punches = [];

  Future<bool> findPunchCardById(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? foundToken = prefs.getString('token');

    var uri = Uri.parse(
        "https://1d11-196-61-37-18.ngrok-free.app/api/v1/punchcard/find-by-userId/$userId");

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": foundToken ?? "",
      "Accept": "application/json"
    };

    Logger().d("Finding punch cards is here");
    Logger().d(uri);
    Logger().d(header.entries);

    var response = await http.post(uri, headers: header);
    Logger().d("Response body: ${response.body}");

    var decodedResponse = jsonDecode(response.body);

    // If the API returns an object with "data" key, extract it like this
    if (decodedResponse is Map && decodedResponse.containsKey('data')) {
      List jsonResponse = decodedResponse['data'];
      setState(() {
        punches =
            jsonResponse.map((punch) => PunchModel.fromJson(punch)).toList();
      });
    } else if (decodedResponse is List) {
      // If the response is already a list (not wrapped in an object)
      List jsonResponse = decodedResponse;
      setState(() {
        punches =
            jsonResponse.map((punch) => PunchModel.fromJson(punch)).toList();
      });
    } else {
      Logger().e("Unexpected response format: $decodedResponse");
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Time Card",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        backgroundColor: const Color(0xFF2BBCE8),
        // toolbarHeight: 85,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: punches.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                          color: const Color(0xFF2BBCE8)),
                    )
                  : ListView.builder(
                      itemCount: punches.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: PunchDetailsCard(
                            punchDate: punches[index].punchDate,
                            punchInTime: punches[index].punchInDateTime,
                            punchOutTime: punches[index].punchOutDateTime,
                            totalHours: punches[index].totalHours,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
