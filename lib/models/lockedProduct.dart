import 'package:flutter/foundation.dart';

class LockedProduct {
  final String id;
  final String title;
  final String lockedBy;
  final String imageUrl;
  final String category;

  LockedProduct({
    @required this.id,
    @required this.title,
    @required this.lockedBy,
    @required this.imageUrl,
    @required this.category,
  });
}
