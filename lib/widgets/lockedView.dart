import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:BookFinder/constants/sizeConfig.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/models/lockedProduct.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:BookFinder/service/notificationService.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LockedView extends StatefulWidget {
  final LockedProduct lockedProduct;
  LockedView({
    @required this.lockedProduct,
  });

  @override
  _LockedViewState createState() => _LockedViewState();
}

class _LockedViewState extends State<LockedView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
        top: 18.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.extraLightBackgroundGray,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: SizeConfig.widthMultiplier * 4.615,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.09,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        widget.lockedProduct.title,
                        style: GoogleFonts.inter(
                          fontSize: SizeConfig.textMultiplier * 2.325,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        widget.lockedProduct.lockedBy,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                          fontSize: SizeConfig.heightMultiplier * 1.6,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.5,
                    ),
                    Text(
                      widget.lockedProduct.category.capitalize(),
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.heightMultiplier * 1.744,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.09,
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 7.69,
                ),
                GestureDetector(
                  onTap: () async {
                    await userRejected(
                        widget.lockedProduct.id, widget.lockedProduct.category);
                    await init(rootUser.email);
                    navigate();
                  },
                  child: Container(
                    width: SizeConfig.widthMultiplier * 15,
                    decoration: BoxDecoration(
                      color: CupertinoColors.destructiveRed,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Icon(MdiIcons.close, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 1.16,
                ),
                GestureDetector(
                  onTap: () async {
                    await userAccepted(
                      widget.lockedProduct.id,
                      widget.lockedProduct.category,
                      widget.lockedProduct.imageUrl,
                    );
                    await init(rootUser.email);
                    navigate();
                  },
                  child: Container(
                    width: SizeConfig.widthMultiplier * 15,
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Icon(MdiIcons.check, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 4.615,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          currentUser: rootUser,
          pageIndex: 3,
        ),
      ),
    );
  }
}
