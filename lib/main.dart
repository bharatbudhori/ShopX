import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/services/admob_services.dart';
import 'package:shop_x/views/welcome_screen.dart';

//import './views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AdMobService.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopX',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
