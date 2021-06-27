import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shop_x/controllers/auth_controller.dart';
//import 'package:shop_x/views/signup_screen.dart';
import 'package:get/get.dart';
//import 'package:shop_x/services/admob_services.dart';

import 'homepage.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      // bottomNavigationBar: Container(
      //   height: 50,
      //   child: AdWidget(
      //     key: UniqueKey(),
      //     ad: AdMobService.createBannerAd()..load(),
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome to ShopX, it's really nice to see you here.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/welcome.png"))),
              ),
              GestureDetector(
                onTap: () =>
                    authController.googleSignIn().whenComplete(() async {
                  User user = FirebaseAuth.instance.currentUser;
                  loggedInUser = user;

                  Get.off(() => HomePage(user));
                }),
                child: Container(
                  height: 70,
                  width: 400,
                  child: Image(
                    image: AssetImage('assets/signin.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Column(
              //   children: <Widget>[
              //     // the login button
              //     MaterialButton(
              //       minWidth: double.infinity,
              //       height: 60,
              //       onPressed: () {
              //         Get.to(() => LoginScreen());
              //       },
              //       // defining the shape
              //       shape: RoundedRectangleBorder(
              //           side: BorderSide(color: Colors.black),
              //           borderRadius: BorderRadius.circular(50)),
              //       child: Text(
              //         "Login",
              //         style:
              //             TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              //       ),
              //     ),
              //     // creating the signup button
              //     SizedBox(height: 20),
              //     MaterialButton(
              //       minWidth: double.infinity,
              //       height: 60,
              //       onPressed: () {
              //         Get.to(() => SignUpScreen());
              //       },
              //       color: Color(0xff0095FF),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(50)),
              //       child: Text(
              //         "Sign up",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 18),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
