import 'dart:convert';

import 'package:ecl_punchin/modules/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TimeCard extends StatefulWidget {
  const TimeCard({super.key});

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {

  User? user;


Future<bool> findPunchCardById(int id, BuildContext context) async {

  var uri = Uri.parse("https://57a2-196-61-37-18.ngrok-free.app/api/v1/punchcard/find-by-userId/$id");

  Map<String, String> headers = {"Content-Type": "application/json"};

  var response = await http.post(uri, headers: headers);

  List jsonResponse = jsonDecode(response.body);

  setState(() {
    // punchCardList = jsonResponse.map((data) => PunchCard.fromJson(data)).toList();
  });

  return true;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Time Card", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
      // centerTitle: true,
      backgroundColor: const Color(0xFF2BBCE8),
      // toolbarHeight: 85,
      automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: const Color(0x772BBCE8),
              child: SizedBox(
                height: 120,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(202, 243, 243, 243)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text("Sunday, 8 December", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: RichText(
                            text: const TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Punch-in time: ',
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: '08:00',
                                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: RichText(
                            text: const TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Punch-out time: ',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text: '17:00',
                                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 13),
                          child: Text("9.0 hrs", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
