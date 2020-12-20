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
          color: Colors.grey[200],
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
                    Text(
                      widget.lockedProduct.title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: SizeConfig.textMultiplier * 2.325,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.9,
                    ),
                    Text(
                      widget.lockedProduct.lockedBy,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w200,
                        color: primaryColor,
                        fontSize: SizeConfig.heightMultiplier * 1.16,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.9,
                    ),
                    Text(
                      widget.lockedProduct.category.capitalize(),
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w300,
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
                FlatButton(
                  minWidth: SizeConfig.widthMultiplier * 2.325,
                  color: transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.red),
                  ),
                  onPressed: () async {
                    await userRejected(
                        widget.lockedProduct.id, widget.lockedProduct.category);
                    await init(rootUser.email);
                    navigate();
                  },
                  child: Icon(MdiIcons.close),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 1.16,
                ),
                FlatButton(
                  minWidth: SizeConfig.widthMultiplier * 2.325,
                  color: transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.green),
                  ),
                  onPressed: () async {
                    await userAccepted(
                      widget.lockedProduct.id,
                      widget.lockedProduct.category,
                      widget.lockedProduct.imageUrl,
                    );
                    await init(rootUser.email);
                    navigate();
                  },
                  child: Icon(MdiIcons.check),
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
