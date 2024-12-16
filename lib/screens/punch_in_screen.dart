import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ecl_punchin/modules/auth/models/punch_card_model.dart';
import 'package:ecl_punchin/modules/auth/models/punching_in_model.dart';
import 'package:ecl_punchin/modules/auth/models/punching_out_model';
import 'package:ecl_punchin/screens/punch_out_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ecl_punchin/modules/auth/models/user_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PunchIn extends StatefulWidget {
  const PunchIn({super.key});

  State<PunchIn> createState() => _PunchInState();
}

class _PunchInState extends State<PunchIn> {

  bool isPunchLoading = false;
  double? currentlatitude;
  double? currentlongitude;
  Position? currentPosition;
  String? currentAddress;
  String? notes;
  User? user;
  String? punchInTime;
  String? punchTime;
  PunchCardModel? punchCardModel;
  List<User> restaurant = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // Call your function here
  //   retrieveUserById(context);
  // }

  File? _selectedImage;
  String base64Image = "";
  String base64String = "";
  bool isPunchedIn = false;
  XFile? _pickedFile;

  String _extractTime(String? punchInTime) {
    if (punchInTime == null) return 'N/A';
    try {
      DateTime parsedTime = DateTime.parse(punchInTime);
      Logger().d("hereeeeeeeeeeeeeeeeeeeee");
      Logger().d(DateFormat('HH:mm:ss').format(parsedTime));

      setState(() {
        punchTime = DateFormat('HH:mm:ss').format(parsedTime);
      });
      return DateFormat('HH:mm:ss').format(parsedTime); // Format as HH:mm:ss
    } catch (e) {
      return 'Invalid Time';
    }
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;

    setState(() {
      _pickedFile = returnedImage;

      List<int> imageBytes = File(_pickedFile!.path).readAsBytesSync();

      base64String = base64Encode(imageBytes);

      Logger().d("converted image");

      Logger().d(base64String);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    retrieveUserById();

    // TODO: implement initState
    super.initState();
  }

  void getCurrentLocation() async {
    await Geolocator.requestPermission();
    await Geolocator.checkPermission();
    await Geolocator.getCurrentPosition().then(
      (value) async {
        Logger()
            .d("Latitude ${value.latitude} and longitude ${value.longitude}");

        setState(() {
          currentlatitude = value.latitude;
          currentlongitude = value.longitude;
        });

        getAddressFromLatLng(value.latitude, value.longitude);
      },
    );
  }

  Future<void> getAddressFromLatLng(double lat, double long) async {
    await placemarkFromCoordinates(lat, long)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
            "${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}";
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> retrieveUserById() async {
    
    Logger().d("Finding User 1");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    _extractTime(prefs.getString('punchInTime'));
    int? userId = prefs.getInt('userId');
    String? foundToken = prefs.getString('token');

    Logger().d("Finding User id");
    Logger().d(userId);

    var uri = Uri.parse(
        "https://65b1-154-161-178-71.ngrok-free.app/api/v1/user/find-by-id/$userId");

    Logger().d("Finding User 2");

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": foundToken ?? ""
    };

    Logger().d("Finding User 3");

    var response = await http.post(uri, headers: header);

    Logger().d("Finding User 4");

    Logger().d(uri);
    Logger().d(response.body);
    Logger().d(foundToken);
    Logger().d(header);

    var jsonResponse = json.decode(response.body);

    Logger().d("Finding User 5");
    Logger().d('$jsonResponse');

    var userData = jsonResponse['data'];
    Logger().d('$userData');

    Logger().d("Finding User 6");

    User foundUser = User.fromJson(userData);
    Logger().d('$foundUser');

    Logger().d("Finding User 7");

    setState(() {
      user = foundUser;
    });
    Logger().d('$user');

    Logger().d("Finding User");
  }

  Future<void> userPunchingIn(PunchingInModel punchIn) async {
    Logger().d("Punching In");

    setState(() {
      isPunchLoading = true; 
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? foundToken = prefs.getString('token');

    var uri = Uri.parse(
        "https://65b1-154-161-178-71.ngrok-free.app/api/v1/punchcard/create");

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": foundToken ?? "",
      "Accept": "application/json"
    };

    Logger().d("THIS IS THE PUNCH IN INFORMATION");

    punchIn.userId = userId;

    Logger().d(punchIn.toJson());

    var response = await http.post(uri,
        headers: header, body: jsonEncode(punchIn.toJson()));

    Logger().d("THIS IS THE RESULT");

    var jsonResponse = json.decode(response.body);
    Logger().d(jsonResponse);

    var punchData = jsonResponse['data'];
    Logger().d(jsonResponse['data']);

    String newPunchInTime = punchData['punchInDateTime'];

    await prefs.setInt('punchId', punchData['id']);
    await prefs.setString('punchInTime', punchData['punchInDateTime']);

    Logger().d("punchId is here");
    int? punchId = prefs.getInt('punchId');
    Logger().d(punchId);

    Logger().d("punchInTime is here");
    String? punchInTimes = prefs.getString('punchInTime');
    Logger().d(punchInTimes);
    Logger().d(punchData['punchInDateTime']);
    Logger().d(punchData['id']);
    Logger().d(newPunchInTime);

    setState(() {
      isPunchLoading = false;
    });

    _extractTime(prefs.getString('punchInTime'));

    await prefs.setString('timeOfPunchIn', _extractTime(prefs.getString('punchInTime')));

    setState(() {
      punchInTime = prefs.getString('punchInTime');
    });

    _pickedFile = null;
    notes = null;

    retrieveUserById();
  }

  Future<void> userPunchingOut(PunchingOutModel punchOut) async {

    setState(() {
      isPunchLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    int? punchId = prefs.getInt('punchId');

    String? foundToken = prefs.getString('token');
    Logger().d("Punching Out");

    var uri = Uri.parse(
        "https://65b1-154-161-178-71.ngrok-free.app/api/v1/punchcard/punchOut");

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": foundToken ?? "",
      "Accept": "application/json"
    };

    Logger().d("punchId is here");

    Logger().d(punchOut.id);

    Logger().d("Punched Out");

    punchOut.id = punchId;
    punchOut.userId = userId;

    var response = await http.post(uri,
        headers: header, body: jsonEncode(punchOut.toJson()));

    var jsonResponse = json.decode(response.body);

    var punchData = jsonResponse['data'];

    setState(() {
      isPunchLoading = false;
    });

    retrieveUserById();
    // setState(() {
    //   isPunchLoading = false;
    // });
  }

  TextEditingController notesTextEdittingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? status = user?.punch ?? "";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: user?.fullName == null
            ? const LinearProgressIndicator(
                color: Colors.blue,
              )
            : Text(
                user!.fullName,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
        backgroundColor: const Color(0xFF2BBCE8),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFF3F3F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("Status:",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: status != "Punched Out"
                          ? Colors.green.withOpacity(0.3)
                          : Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 5),
                      child: Text(
                        status!, // isPunchedIn ? "$currentAddress" : "Punched Out",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: status != "Punched Out"
                              ? const Color(0xFF419B86)
                              : const Color(0xFFC34B4F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: _pickImageFromCamera,
                child: _pickedFile == null
                    ? Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text("Take Picture",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      )
                    : SizedBox(
                        height: 300,
                        width: 200,
                        child: Image.file(File(_pickedFile!.path)),
                      ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: status != "Punched Out"
                  ? Container(
                      width: 385, // ??
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                        child: Text(
                          "You punched in at $punchTime",
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: notesTextEdittingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0)),
                  hintText: "Enter notes here...",
                  hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: status != "Punched Out"
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: const Color(0xFF2BBCE8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: isPunchLoading
                            ? null // Disable button if loading
                            : () {
                                setState(() {
                                  isPunchLoading = true;
                                });

                                PunchingInModel punchingInModel = PunchingInModel(
                                  locationName: currentAddress,
                                  longitude: '$currentlongitude',
                                  latitude: '$currentlatitude',
                                  punchInNotes: notesTextEdittingController.text,
                                  picture: base64String,
                                );

                                PunchingOutModel punchingOutModel = PunchingOutModel(
                                  locationName: currentAddress,
                                  longitude: '$currentlongitude',
                                  latitude: '$currentlatitude',
                                  punchOutNotes: notesTextEdittingController.text,
                                  picture: base64String,
                                );

                                if (status != "Punched Out") {
                                  userPunchingOut(punchingOutModel); // Punch Out action
                                } else {
                                  userPunchingIn(punchingInModel); // Punch In action
                                }

                                setState(() {
                                  isPunchedIn = !isPunchedIn; // Toggle the punch state
                                  isPunchLoading = false; // Reset loading state
                                });
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isPunchLoading
                                ? LoadingAnimationWidget.discreteCircle(color: Colors.white, size: 30)
                                : const SizedBox.shrink(),
                            const SizedBox(width: 10),
                            isPunchLoading
                                ? const Text(
                                    'Processing...',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    status != "Punched Out" ? "Punch Out" : "Punch In",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        ),
                      )               
                      : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: const Color(0xFF2BBCE8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          PunchingInModel punchingInModel = PunchingInModel(
                            locationName: currentAddress,
                            longitude: '$currentlongitude',
                            latitude: '$currentlatitude',
                            punchInNotes: notesTextEdittingController.text,
                            picture: base64String,
                          );

                          PunchingOutModel punchingOutModel = PunchingOutModel(
                            locationName: currentAddress,
                            longitude: '$currentlongitude',
                            latitude: '$currentlatitude',
                            punchOutNotes: notesTextEdittingController.text,
                            picture: base64String,
                          );
                          // userPunchingOut(punchingOutModel);
                          userPunchingIn(punchingInModel);

                          // status != "Punched Out" ? userPunchingOut(punchingOutModel) :  userPunchingIn(punchingInModel);

                          // getLocation();
                          setState(() {
                            isPunchedIn = !isPunchedIn;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              status != "Punched Out"
                                  ? "Punch Out"
                                  : "Punch In",
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
            const SizedBox(height: 25),
            const Text("Punch In & Select Time",
                style: TextStyle(fontSize: 15),),

                if ( isPunchLoading)
           Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.hexagonDots(
                    color: const Color(0xFF2BBCE8),
                    size: 50,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Please wait while data is being fetched',
                    style: TextStyle(color: Color(0xFF2BBCE8), fontSize: 15),
                  ),
                ],
              ),
            )
          
          ],
        ),
      ),
    );
  }
}
