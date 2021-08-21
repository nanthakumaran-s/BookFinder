import 'package:flutter/material.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/constants/sizeConfig.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:BookFinder/widgets/lockedView.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            MdiIcons.chevronLeft,
            size: SizeConfig.widthMultiplier * 10.25,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(
                currentUser: rootUser,
                pageIndex: 3,
              ),
            ),
          ),
        ),
        title: Text(
          NotificationPageStrings.title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: SizeConfig.textMultiplier * 2.9,
          ),
        ),
      ),
      body: SafeArea(
        child: buildLockedProduct(),
      ),
    );
  }

  buildLockedProduct() {
    List<LockedView> lockedView = [];
    lockedProducts.forEach((element) {
      lockedView.add(
        LockedView(lockedProduct: element),
      );
    });
    return ListView(
      children: lockedView,
    );
  }
}
