import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PunchOut extends StatefulWidget {
  const PunchOut({super.key});

  @override
  State<PunchOut> createState() => _PunchOutState();
}

class _PunchOutState extends State<PunchOut> {

Future _pickImageFromCamera() async {
  final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  if(returnedImage == null) return;
  setState(() {
    _selectedImage = File(returnedImage.path);
  });
}

  File ? _selectedImage;

  @override
  Widget build(BuildContext context) {    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Kelvin Yirenkyi", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
      // centerTitle: true,
      backgroundColor: const Color(0xFF2BBCE8),
      // toolbarHeight: 85,
      automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Column(
          children: [Container(color: const Color(0xFFF3F3F3),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Status:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFF419B86).withOpacity(0.3),borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                    child: Text("Punched In", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF419B86)),),
                  ))
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                _pickImageFromCamera();
              },
              child: Row(
                children: [
                  Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: BoxShape.circle),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 30.0,
                        )
                      ],
                    ),
              ),
              const SizedBox(width: 15,),
                  const Text("Take Picture", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15,),
                    Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15),
  child: Container(
    width: 385, // ??
    height: 50, 
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Padding(
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
      child: Text(
        "You punched in at 09:11", 
        style: TextStyle(fontSize: 15),
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ),
),
            const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0)), 
                                        hintText: "Enter notes here...", 
                                        hintStyle: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400)
                                        ),
                                      ),
                                    ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: const Color(0xFF2BBCE8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                         ),
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Punch Out",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
          ),
          const SizedBox(height: 25,),
          const Text("Punch In & Select Time", style: TextStyle(fontSize: 15),),
          ],
          
        ),
      ),
    );
  }
}