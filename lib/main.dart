import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guardiana/db/shared-pref.dart';
import 'package:guardiana/guardian/guardian_home_screen.dart';
import 'package:guardiana/user/bottom_page.dart';
import 'package:guardiana/user/bottom_page/home_screen.dart';
import 'package:guardiana/user/login_screen.dart';
import 'package:guardiana/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyB391AQxn9-Cv_J4ombQ9skM7iPOcsAvZ8",
            appId: "1:426529831338:android:e0693f19d8960f5424d3d3",
            messagingSenderId: "426529831338",
            projectId: "guardianav1",
          ),
        )
      : await Firebase.initializeApp();
  await MySharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.firaSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: FutureBuilder(
            future: MySharedPreferences.getUsertype(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == "") {
                return LoginPage();
              }
              if (snapshot.data == "user") {
                return BottomPage();
              }
              if (snapshot.data == "parent") {
                return GuardianHomeScreen();
              }
              return progressIndicator(context);
            }));
  }
}

/*class CheckAuth extends StatelessWidget {
  //const CheckAuth({super.key});
  checkdata(){
    if (MySharedPreferences.getUsertype()=='parent') {
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}*/
