//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/auth_controller.dart';
import 'package:shop_x/views/homepage.dart';
import 'package:shop_x/views/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController = Get.put(AuthController());

  String email;
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignup() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      authController.signUp(email.trim(), password, context).then((value) {
        if (value != null) {
          Get.offAll(() => HomePage());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FlutterLogo(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Signup Here",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty";
                          } else if (!_val.contains('@') ||
                              !_val.contains('.com')) {
                            return "Please enter a valid email.";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return "Can't be empty";
                            } else if (_val.length < 6) {
                              return "Password too short";
                            } else {
                              return null;
                            }
                          },

                          // validator: MultiValidator([
                          //   RequiredValidator(
                          //       errorText: "This Field Is Required."),
                          //   MinLengthValidator(6,
                          //       errorText: "Minimum 6 Characters Required.")
                          // ]),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: handleSignup,
                        // color: Colors.green,
                        // textColor: Colors.white,
                        child: Text(
                          "Sign Up",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () =>
                    authController.googleSignIn().whenComplete(() async {
                  //User user = FirebaseAuth.instance.currentUser;

                  Get.offAll(() => HomePage());
                }),
                child: Image(
                  image: AssetImage('assets/signin.png'),
                  width: 200.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () {
                  // send to login screen
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  "Login Here",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
