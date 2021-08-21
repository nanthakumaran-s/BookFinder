import 'package:BookFinder/screens/SingleProduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/product.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/service/productService.dart';

class ProductPage extends StatefulWidget {
  final UserData currentUser;
  final String page;
  final String category;
  final List<Product> product;
  ProductPage({
    @required this.currentUser,
    @required this.page,
    @required this.category,
    @required this.product,
  });
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    widget.product.clear();
    getCollection(widget.category);
    getObj();
  }

  getObj() async {
    await getObjects(
        widget.currentUser.college, widget.product, widget.currentUser.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 20.0,
                  ),
                  child: Text(
                    widget.page,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Divider(
                  color: black,
                  indent: 15.0,
                  endIndent: 15.0,
                  thickness: 0.6,
                ),
                buildProduct(),
              ],
            ),
            widget.product.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset(
                          //   'images/no_content.svg',
                          //   height: 230.0,
                          // ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Text(
                            'No ${widget.category.capitalize()} Available in your College',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Text(CommonStrings.emptyString),
          ],
        ),
      ),
    );
  }

  buildProduct() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        for (var i = 0; i < widget.product.length; i++)
          containerView(widget.product[i]),
      ],
    );
  }

  containerView(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.lightBackgroundGray,
            blurRadius: 3.0,
          ),
        ],
      ),
      height: 200,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 0.33 / 0.4,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    product.imageUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  product.nameOfUser,
                  style: GoogleFonts.inter(
                    color: CupertinoColors.secondaryLabel,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  product.mail,
                  style: GoogleFonts.inter(
                    color: CupertinoColors.destructiveRed,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  product.college,
                  style: GoogleFonts.inter(
                    color: CupertinoColors.darkBackgroundGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleProduct(
                          currentUser: widget.currentUser,
                          singleProduct: product,
                          category: widget.category,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFEDEE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Text(
                        "View More",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          color: Color(0xFFE00000),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
