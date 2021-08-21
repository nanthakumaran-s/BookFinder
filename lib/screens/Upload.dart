import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/service/imageService.dart';
import 'package:BookFinder/service/uploadService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

final StorageReference storageReference = FirebaseStorage.instance.ref();

class UploadPage extends StatefulWidget {
  final UserData currentUser;
  UploadPage({
    @required this.currentUser,
  });
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  File file;
  bool isUploading = false;
  bool showAlert = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                UploadStrings.donateStr,
                style: TextStyle(
                  fontFamily: playfairDisplay,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              Text(
                UploadStrings.catchyStr,
                style: TextStyle(
                  fontFamily: roboto,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              buildDonateButton(MdiIcons.bookOpenPageVariantOutline,
                  CommonStrings.books.capitalize(), CommonStrings.books),
              SizedBox(
                height: 7,
              ),
              buildDonateButton(
                  MdiIcons.pen,
                  CommonStrings.stationary.capitalize(),
                  CommonStrings.stationary),
            ],
          ),
        ),
      ),
    );
  }

  buildDonateButton(icon, text, thing) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await getCollection(thing);
              showModalBottomSheet(
                isDismissible: false,
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: ListView(
                            children: [
                              Divider(
                                endIndent: 150.0,
                                indent: 150.0,
                                thickness: 5.0,
                                height: 25.0,
                                color: Colors.grey[800],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Center(
                                child: Text(
                                  'Donate $thing',
                                  style: TextStyle(
                                    fontFamily: playfairDisplay,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                              Form(
                                key: _formkey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: TextFormField(
                                    controller: titleController,
                                    validator: RequiredValidator(
                                      errorText: ErrorText.reqField,
                                    ),
                                    autocorrect: false,
                                    cursorColor: primaryColor,
                                    decoration: InputDecoration(
                                      labelText: "Title",
                                      labelStyle: GoogleFonts.nunitoSans(
                                        color: CupertinoColors.inactiveGray,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: CupertinoColors.destructiveRed,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: CupertinoColors.destructiveRed,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              file != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(
                                                file,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(CommonStrings.emptyString),
                              SizedBox(
                                height: 3.0,
                              ),
                              InkWell(
                                onTap: () async {
                                  var _file = await takePhoto();
                                  setState(() {
                                    this.file = _file;
                                  });
                                },
                                child: Text(
                                  UploadStrings.chooseImg,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    color: primaryColor,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 13.0,
                              ),
                              showAlert
                                  ? Center(
                                      child: Text(
                                        UploadStrings.selectImg,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: playfairDisplay,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    )
                                  : Text(CommonStrings.emptyString),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 25.0,
                          right: 25.0,
                          child: GestureDetector(
                            onTap: () async {
                              if (_formkey.currentState.validate()) {
                                if (file == null) {
                                  setState(() {
                                    showAlert = true;
                                  });
                                } else {
                                  setState(() {
                                    showAlert = false;
                                    isUploading = true;
                                  });
                                  var postId = Uuid().v4();
                                  StorageUploadTask task = storageReference
                                      .child('post_$postId.jpg')
                                      .putFile(file);
                                  StorageTaskSnapshot storageSnap =
                                      await task.onComplete;
                                  String url =
                                      await storageSnap.ref.getDownloadURL();
                                  upload(widget.currentUser, url,
                                      titleController.text);
                                  setState(() {
                                    file = null;
                                    isUploading = false;
                                    titleController.text =
                                        CommonStrings.emptyString;
                                  });
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: CupertinoColors.destructiveRed,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors
                                        .extraLightBackgroundGray,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Text(
                                CommonStrings.upload,
                                style: GoogleFonts.inter(
                                  color: white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25.0,
                          left: 25.0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                file = null;
                                isUploading = false;
                                titleController.text =
                                    CommonStrings.emptyString;
                                showAlert = false;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: CupertinoColors.destructiveRed,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors
                                        .extraLightBackgroundGray,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Text(
                                CommonStrings.cancel,
                                style: GoogleFonts.inter(
                                  color: white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        isUploading
                            ? Positioned.fill(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5,
                                    sigmaY: 5,
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            : Text(CommonStrings.emptyString),
                      ],
                    );
                  });
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: CupertinoColors.destructiveRed,
                    //   width: 0.4,
                    // ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.extraLightBackgroundGray,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 38.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        text,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 23.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
