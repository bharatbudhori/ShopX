import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();

// a simple sialog to be visible everytime some error occurs
  showErrDialog(BuildContext context, String err) {
    // to hide the keyboard, if it is still p
    FocusScope.of(context).requestFocus(new FocusNode());
    return Get.dialog(Container(
      //context: context,
      child: AlertDialog(
        title: Text("Error"),
        content: Text(err),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      ),
    ));
  }

// many unhandled google error exist
// will push them soon
  Future<bool> googleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await auth.signInWithCredential(credential);
      print(result.user);

      User user = auth.currentUser;
      print(user.uid);

      return Future.value(true);
    } else {
      return null;
    }
  }

// instead of returning true or false
// returning user to directly access UserID
  Future<User> signin(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result =
          await auth.signInWithEmailAndPassword(email: email, password: email);
      User user = result.user;
      // return Future.value(true);
      return Future.value(user);
    } catch (e) {
      // simply passing error code as a message
      print(e.code);
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_WRONG_PASSWORD':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_USER_NOT_FOUND':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_USER_DISABLED':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          showErrDialog(context, e.code);
          break;
      }
      // since we are not actually continuing after displaying errors
      // the false value will not be returned
      // hence we don't have to check the valur returned in from the signin function
      // whenever we call it anywhere
      return Future.value(null);
    }
  }

// change to Future<FirebaseUser> for returning a user
  Future<User> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: email);
      User user = result.user;
      return Future.value(user);
      // return Future.value(true);
    } catch (error) {
      print(error);
      Get.snackbar('Error Signing in', error.toString());
      return Future.value(null);
    }
  }

  Future<void> signOutUser() async {
    //User user = auth.currentUser;
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }

    //return Future.value(true);
  }
}
