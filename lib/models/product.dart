import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String mail;
  final String title;
  final String imageUrl;
  final String nameOfUser;
  final String college;
  final bool locked;
  final String lockedBy;

  Product({
    @required this.id,
    @required this.mail,
    @required this.title,
    @required this.imageUrl,
    @required this.nameOfUser,
    @required this.college,
    @required this.locked,
    @required this.lockedBy,
  });

  factory Product.from(
      id, mail, title, imageUrl, nameOfUser, college, locked, lockedBy) {
    return Product(
      id: id,
      mail: mail,
      title: title,
      imageUrl: imageUrl,
      nameOfUser: nameOfUser,
      college: college,
      locked: locked,
      lockedBy: lockedBy,
    );
  }
}
