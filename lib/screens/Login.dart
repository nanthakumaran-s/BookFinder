import 'package:barbarian/barbarian.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/constants/sizeConfig.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:BookFinder/screens/SignUp.dart';
import 'package:BookFinder/service/loginService.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController passcodeController = TextEditingController();
  String msg = CommonStrings.emptyString;
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: ErrorText.reqField),
    EmailValidator(errorText: ErrorText.reqMail),
  ]);

  @override
  void initState() {
    super.initState();
    getCollection();
  }

  validate() async {
    if (formkey.currentState.validate()) {
      await checkEmail();
    }
  }

  checkEmail() async {
    var _val = await emailcheck(mailController.text);
    if (_val != null) {
      if (passcodeController.text == _val['password']) {
        setState(() {
          msg = LoginStrings.authenticated;
        });
        UserData currentUser = await getUser(mailController.text);
        Barbarian.write('mail', currentUser.email);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(
                  currentUser: currentUser,
                )));
      } else {
        setState(() {
          msg = LoginStrings.wrongPass;
        });
      }
    } else {
      setState(() {
        msg = LoginStrings.noMatch;
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
              padding: EdgeInsets.all(SizeConfig.widthMultiplier * 5.897),
              children: [
                Text(
                  LoginStrings.login,
                  style: TextStyle(
                    fontFamily: playfairDisplay,
                    color: black,
                    fontSize: SizeConfig.textMultiplier * 5,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4.06,
                ),
                Text(
                  msg,
                  style: TextStyle(
                    fontFamily: roboto,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.textMultiplier * 1.744,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2.325,
                ),
                Text(
                  CommonStrings.mailId,
                  style: TextStyle(
                    color: black,
                    fontSize: SizeConfig.textMultiplier * 2.093,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.16,
                ),
                TextFormField(
                  controller: mailController,
                  validator: emailValidator,
                  autocorrect: false,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2.325),
                Text(
                  CommonStrings.password,
                  style: TextStyle(
                    color: black,
                    fontSize: SizeConfig.textMultiplier * 2.093,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2.325,
                ),
                TextFormField(
                  controller: passcodeController,
                  validator: RequiredValidator(errorText: ErrorText.reqField),
                  autocorrect: false,
                  obscureText: true,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 4.651),
                FlatButton(
                  onPressed: validate,
                  padding: EdgeInsets.all(SizeConfig.widthMultiplier * 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: primaryColor)),
                  child: Text(
                    CommonStrings.submit,
                    style: TextStyle(
                      fontFamily: playfairDisplay,
                      fontSize: SizeConfig.textMultiplier * 2.3255,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 6.976),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LoginStrings.lowText1,
                      style: TextStyle(
                        fontFamily: roboto,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        LoginStrings.lowText2,
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
