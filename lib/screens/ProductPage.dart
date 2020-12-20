import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/product.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/service/productService.dart';
import 'package:BookFinder/widgets/productTile.dart';

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
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 20.0,
                  ),
                  child: Text(
                    widget.page,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: playfairDisplay,
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
                          SvgPicture.asset(
                            'images/no_content.svg',
                            height: 230.0,
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Text(
                            'No ${widget.category.capitalize()} Available in your College',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
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
    List<GridTile> gridTiles = [];
    widget.product.forEach((post) {
      gridTiles.add(GridTile(
        child: ProductTile(
          currentUser: widget.currentUser,
          product: post,
          category: widget.category,
        ),
      ));
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTiles,
      ),
    );
  }
}
