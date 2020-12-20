import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:BookFinder/constants/colors.dart';
import 'package:BookFinder/constants/fonts.dart';
import 'package:BookFinder/models/product.dart';
import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/screens/SingleProduct.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  final UserData currentUser;
  final String category;
  ProductTile({
    @required this.product,
    @required this.currentUser,
    @required this.category,
  });
  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SingleProduct(
              currentUser: widget.currentUser,
              singleProduct: widget.product,
              category: widget.category,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1.2 / 1,
              child: Container(
                margin: EdgeInsets.all(1.4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      widget.product.imageUrl,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.title,
                style: TextStyle(
                  color: primaryColor,
                  fontFamily: playfairDisplay,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'From: ${widget.product.college}',
                style: TextStyle(
                  fontFamily: roboto,
                  fontSize: 13.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                'By: ${widget.product.nameOfUser}',
                style: TextStyle(
                  fontFamily: roboto,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                widget.product.mail,
                style: TextStyle(
                  fontFamily: roboto,
                  fontSize: 11.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
