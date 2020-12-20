import 'package:barbarian/barbarian.dart';
import 'package:flutter/material.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:BookFinder/screens/Login.dart';
import 'package:BookFinder/service/dbConfig.dart';
import 'package:BookFinder/service/loginService.dart';
import 'package:splashscreen/splashscreen.dart';

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
      title: Text(
        'BookFinder',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image:
          Image.network('https://hackwithcw.tech/static/media/cw.5ba5ff53.png'),
      backgroundColor: white,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
      loadingText: Text('Made by Nanthakumaran'),
      loaderColor: primaryColor,
    );
  }
}
