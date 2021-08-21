import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:BookFinder/screens/Notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:BookFinder/constants/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:BookFinder/service/profileService.dart';
import 'package:barbarian/barbarian.dart';
import 'Login.dart';

class ProfilePage extends StatefulWidget {
  final UserData currentUser;
  final UserData profileVisitor;
  ProfilePage({
    @required this.currentUser,
    @required this.profileVisitor,
  });
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCollection();
  }

  sendEmail() async {
    final Email email = Email(
      body: '''
Hey ${widget.currentUser.name}... 
I'm ${widget.profileVisitor.name} from ${widget.profileVisitor.college}.. Good to see you... 
I came accross your profile and willing to stay connected with you. Can we meet and discuss?
I'm so happy if I can get your number...
See you soon.. bye
''',
      subject: ProfileStrings.emailSub,
      recipients: ['${widget.currentUser.email}'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  validate() async {
    if (formkey.currentState.validate()) {
      await updateName(widget.currentUser.email, nameController.text);
      Navigator.pop(context);
    }
  }

  editProfile() {
    return showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ProfileConst.padding),
            ),
            elevation: 0,
            backgroundColor: transparent,
            child: Container(
              padding: EdgeInsets.only(
                  top: ProfileConst.padding * 2, bottom: ProfileConst.padding),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: white,
                borderRadius: BorderRadius.circular(ProfileConst.padding),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    ProfileStrings.updateName,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 18.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: ProfileConst.padding,
                        right: ProfileConst.padding),
                    child: Form(
                      key: formkey,
                      child: TextFormField(
                        validator:
                            RequiredValidator(errorText: ErrorText.reqField),
                        controller: nameController,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          labelText: "Your Name",
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
                    height: 18.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_outlined,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        ProfileStrings.note,
                        style: GoogleFonts.inter(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: ProfileConst.padding),
                      child: GestureDetector(
                        onTap: validate,
                        child: Container(
                          child: Text(
                            CommonStrings.update,
                            style: TextStyle(
                              fontFamily: roboto,
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  buildButton({String label, Function function}) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        decoration: BoxDecoration(
          color: CupertinoColors.destructiveRed,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: GoogleFonts.sourceSansPro(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  buildProfileButton() {
    bool isProfileOwner =
        widget.profileVisitor.email == widget.currentUser.email;
    if (isProfileOwner) {
      return buildButton(
        label: ProfileStrings.editPro,
        function: editProfile,
      );
    } else {
      return buildButton(
        label: ProfileStrings.sendMail,
        function: sendEmail,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CupertinoColors.black,
        centerTitle: true,
        title: Text(
          ProfileStrings.profile,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          widget.profileVisitor.email != widget.currentUser.email
              ? SizedBox()
              : Positioned(
                  left: 25.0,
                  top: 25.0,
                  child: IconButton(
                    onPressed: () async {
                      await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => NotificationPage()));
                    },
                    icon: Icon(
                      CupertinoIcons.bell_fill,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ),
          (lockedProducts.isEmpty ||
                  widget.profileVisitor.email != widget.currentUser.email)
              ? SizedBox()
              : Positioned(
                  left: 55.0,
                  top: 30.0,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: new BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
          widget.profileVisitor.email != widget.currentUser.email
              ? SizedBox()
              : Positioned(
                  right: 25.0,
                  top: 25.0,
                  child: IconButton(
                    onPressed: logout,
                    icon: Icon(
                      MdiIcons.logout,
                      color: primaryColor,
                      size: 30.0,
                    ),
                  ),
                ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.currentUser.photoUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 125.0,
                            height: 125.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(
                            CupertinoIcons.person_alt_circle,
                            size: 125.0,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          widget.currentUser.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: roboto,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          widget.currentUser.email,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.inactiveGray,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.currentUser.college,
                          style: GoogleFonts.inter(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        buildProfileButton(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  logout() async {
    Barbarian.delete('mail');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
