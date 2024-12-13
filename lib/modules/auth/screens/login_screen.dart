import 'dart:convert';

import 'package:ecl_punchin/modules/auth/models/user_model.dart';
import 'package:http/http.dart' as http;

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:aad_oauth/model/failure.dart';
import 'package:aad_oauth/model/token.dart';
import 'package:ecl_punchin/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;

  final _microsoftSignIn = AadOAuth(Config(
    // If you dont have a special tenant id, use "common"
    tenant: "common",
    clientId: "7426fff8-28e1-4b78-8c57-eba7d2d87816",
    // Replace this with your client id ("Application (client) ID" in the Azure Portal)
    responseType: "code",
    scope: "User.Read User.ReadBasic.All",
    redirectUri:
        "msauth://com.example.ecl_punchin/hyOO%2FXSiCQvGcPDoA8%2F2xATQZi8%3D",
    loader: const Center(child: CircularProgressIndicator()),
    navigatorKey: navigatorKey,
  ));

  _loginWithMicrosoft() async {
    var result = await _microsoftSignIn.login();

    setState(() {
      isloading = true;
    });

    result.fold(
      (Failure failure) {
        // Auth failed, show error
        print('Login failed: $failure');
      },
      (Token token) async {
        if (token.accessToken == null) {
          print('Access token is null.');
          return;
        }

        Logger()
            .d('Logged in successfully, Access Token: ${token.accessToken!}');

        // Call Microsoft Graph API to get user details
        final userDetails = await _getUserDetails(token.accessToken!);

        if (userDetails != null) {
          Logger().d('User Details: $userDetails');
          User user = User(
            firstName: userDetails["givenName"],
            lastName: userDetails["surname"],
            fullName: userDetails["displayName"],
            jobTitle: userDetails["jobTitle"],
            mobilePhone: userDetails["mobilePhone"] ?? " ",
            microsoftId: userDetails["id"],
            email: userDetails["mail"],
            status: "",
            deleteStatus: "",
            image: "",
            punchInStatus: "",
            punch: "",
          );
          // Perform necessary actions with user details

          authenticate(user, context);
        }

        // Optionally logout
        await _microsoftSignIn.logout();
      },
    );
  }

  Future<bool> authenticate(User user, BuildContext context) async {
    //create uri
    var uri = Uri.parse(
        "https://1d11-196-61-37-18.ngrok-free.app/api/v1/auth/microsoft");
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body

    //convert the above data into json
    var body = json.encode(user.toJson());

    Logger().d('User logging in:');

    Logger().d('User logging in with: $body');

    var response = await http.post(uri, headers: headers, body: body);

    Logger().d('User logged in:');

    //print the response body
    // print("${response.body.data}");

    Map<String, dynamic> parsedJson = jsonDecode(response.body);

    Logger().d('User logged in:');

    Logger().d('User logged in: $parsedJson[responseCode]');

    if (parsedJson['responseCode'] == "000") {
      var data = parsedJson['data']; // Access the 'data' object
      var token = parsedJson['token'];

      var userId = data['id']; // Retrieve the 'id' field from 'data'
      var email = data['email'];
      var password = data['password'];

      print("User ID: $userId");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', userId);
      await prefs.setString('email', email);
      await prefs.setString('token', token);

      print(parsedJson['responseCode']);
      print("BODY CONTAINS DATA");
      print(parsedJson);
      // print("${response.body.data}");

      Navigator.pushNamed(context, '/main-screen');
      setState(() {
        isloading = false;
      });
    } else {
      print("No data found in response.");
    }

    return true;
  }

  Future<Map<String, dynamic>?> _getUserDetails(String accessToken) async {
    final url = Uri.parse("https://graph.microsoft.com/v1.0/me");
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch user details: ${response.statusCode}');
      print('Response: ${response.body}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () => _loginWithMicrosoft(),
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal:70, vertical: 15),
      //       child: Text('Log in with Microsoft', style: TextStyle(color: Colors.white, fontSize: 15),),
      //     ),
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: const Color(0xFF66AAE1),

      //     ),
      //   ),
      // ),

      body: isloading
          ? Center(
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
          : Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/ecl_office.jpg',
                    fit: BoxFit.cover,
                  ),
                ),

                // Black overlay on the background image
                Positioned.fill(
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.7), // Black overlay on the background
                  ),
                ),

                // Elevated Button with white opacity overlay
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: PopScope(
                      // canPop: false,
                      child: ElevatedButton(
                        onPressed: () => _loginWithMicrosoft(),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 70, vertical: 15),
                          child: Text(
                            'Log in with Microsoft',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
