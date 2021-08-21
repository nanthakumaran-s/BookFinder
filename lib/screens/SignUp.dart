import 'package:barbarian/barbarian.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:BookFinder/screens/Login.dart';
import 'package:BookFinder/service/signUpService.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    getCollection();
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: ErrorText.reqPass),
    MinLengthValidator(8, errorText: ErrorText.eightDigit),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: ErrorText.specialChar)
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: ErrorText.reqField),
    EmailValidator(errorText: ErrorText.reqMail),
  ]);

  String password;
  String msg = CommonStrings.emptyString;
  String photoUrl = CommonStrings.emptyString;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passcodeController = TextEditingController();
  TextEditingController collegeNameController = TextEditingController();

  validate() async {
    if (formkey.currentState.validate()) {
      await checkEmail();
    }
  }

  getGmail() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    nameController.text = googleSignInAccount.displayName;
    mailController.text = googleSignInAccount.email;
    photoUrl = googleSignInAccount.photoUrl;
    setState(() {});
    _googleSignIn.signOut();
  }

  checkEmail() async {
    var _val = await emailcheck(mailController.text);
    if (_val == false) {
      UserData currentUser = await uploaduser(
          nameController.text,
          mailController.text,
          collegeNameController.text,
          passcodeController.text,
          photoUrl);
      Barbarian.write('mail', currentUser.email);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(
                currentUser: currentUser,
              )));
    } else {
      setState(() {
        msg = SignUpStrings.mailExist;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: formkey,
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.all(23.0),
              children: [
                Text(
                  SignUpStrings.signUp,
                  style: TextStyle(
                    fontFamily: playfairDisplay,
                    color: black,
                    fontSize: 43.0,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  msg,
                  style: TextStyle(
                    fontFamily: roboto,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: nameController,
                  validator: RequiredValidator(errorText: ErrorText.reqField),
                  autocorrect: false,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: "Name",
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
                SizedBox(height: 20.0),
                TextFormField(
                  controller: mailController,
                  validator: emailValidator,
                  autocorrect: false,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: "Mail",
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
                SizedBox(height: 20.0),
                TextFormField(
                  controller: collegeNameController,
                  validator: RequiredValidator(errorText: ErrorText.reqField),
                  autocorrect: false,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: "College Name",
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
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: passcodeController,
                  validator: passwordValidator,
                  autocorrect: false,
                  obscureText: true,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: "Password",
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
                SizedBox(height: 40.0),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: validate,
                  color: CupertinoColors.destructiveRed,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: primaryColor)),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      SignUpStrings.lowText1,
                      style: TextStyle(
                        fontFamily: roboto,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        SignUpStrings.lowText2,
                        style: TextStyle(
                          color: primaryColor,
                          fontFamily: roboto,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
