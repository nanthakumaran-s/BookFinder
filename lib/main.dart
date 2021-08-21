import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/screens/SplashScreen.dart';
import 'constants/sizeConfig.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Book Finder',
          theme: ThemeData.light().copyWith(
            accentColor: primaryColor,
            primaryColor: primaryColor,
          ),
          home: Splash(),
        );
      },
    );
  }
}
