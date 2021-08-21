import 'dart:ui';

import 'package:barbarian/barbarian.dart';
import 'package:flutter/material.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:BookFinder/screens/Login.dart';
import 'package:BookFinder/service/dbConfig.dart';
import 'package:BookFinder/service/loginService.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  // ignore: override_on_non_overriding_member
  Future<Widget> loadFromFuture() async {
    await connectDB();
    await Barbarian.init();
    String mail = Barbarian.read('mail');
    if (mail == null) {
      return Future.value(Login());
    } else {
      await getCollection();
      UserData currentUser = await getUser(mail);
      return Future.value(HomePage(
        currentUser: currentUser,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterFuture: loadFromFuture(),
      // seconds: 3000,
      title: Text(
        'BookFinder',
        style: GoogleFonts.nunitoSans(
          fontSize: 30,
        ),
      ),
      image: Image.asset(
        "images/icon.png",
      ),
      backgroundColor: white,
      photoSize: 100.0,
      loadingText: Text(
        'Made by Nanthakumaran S & Saran VT',
        style: GoogleFonts.sourceSansPro(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      loaderColor: primaryColor,
    );
  }
}
