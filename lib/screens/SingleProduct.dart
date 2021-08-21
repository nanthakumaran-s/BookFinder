import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/product.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:BookFinder/screens/Profile.dart';
import 'package:BookFinder/service/lockProduct.dart';
import 'package:BookFinder/service/loginService.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleProduct extends StatefulWidget {
  final UserData currentUser;
  final Product singleProduct;
  final String category;
  SingleProduct({
    @required this.currentUser,
    @required this.singleProduct,
    @required this.category,
  });
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            MdiIcons.chevronLeft,
            size: 40.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(
                currentUser: widget.currentUser,
                pageIndex: widget.category == CommonStrings.stationary ? 1 : 0,
              ),
            ),
          ),
        ),
        title: Text(
          SingleProductStrings.title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AspectRatio(
              aspectRatio: 0.24 / 0.3,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.singleProduct.imageUrl,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              widget.singleProduct.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                color: primaryColor,
                fontSize: 32.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(
              indent: 75.0,
              endIndent: 75.0,
              thickness: 0.5,
              color: black,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.singleProduct.college,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 23.0,
            ),
            GestureDetector(
              onTap: () async {
                UserData currentUser = await getUser(widget.singleProduct.mail);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            currentUser: currentUser,
                            profileVisitor: widget.currentUser)));
              },
              child: Text(
                widget.singleProduct.nameOfUser.capitalize(),
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  color: CupertinoColors.link,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Text(
              widget.singleProduct.mail,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: sendEmail,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.destructiveRed,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Center(
                    child: Text(
                      CommonStrings.getIt,
                      style: GoogleFonts.inter(
                        color: white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 23.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Note: If you click get it now and mail the donater, the product will be locked and no more available in the finiding section (It may take some time to reflect). If you aren\'t getting it from the donator, kindly inform him/her to reject the proposal',
                textAlign: TextAlign.justify,
                style: GoogleFonts.roboto(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  sendEmail() async {
    await lockProduct(
        widget.category, widget.singleProduct.id, widget.currentUser.email);
    final Email email = Email(
      body: '''
Hey ${widget.singleProduct.nameOfUser}...
I'm ${widget.currentUser.name}. I have seen your product at BookFinder app. I wish to get the product '${widget.singleProduct.title}'. Will meet one day... I like to get your number for further more contacts.
This is my mail and waiting for your reply.






Note from BookFinder: Kindly reject the product in notification, if it is not accepted by ${widget.currentUser.name}.
Regards Nanthakumaran S (Creator of BookFinder)
''',
      subject: 'Wishing to get the product: ${widget.singleProduct.title}',
      recipients: ['${widget.singleProduct.mail}'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          currentUser: widget.currentUser,
          pageIndex: widget.category == CommonStrings.stationary ? 1 : 0,
        ),
      ),
    );
  }
}
