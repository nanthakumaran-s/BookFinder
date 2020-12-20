import 'package:flutter/foundation.dart';

class UserData {
  final String name;
  final String email;
  final String photoUrl;
  final String college;
  UserData({
    @required this.name,
    @required this.email,
    @required this.photoUrl,
    @required this.college,
  });
}
