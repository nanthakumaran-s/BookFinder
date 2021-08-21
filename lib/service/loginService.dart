import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/service/dbConfig.dart';
import 'package:mongo_dart/mongo_dart.dart';

var coll;

getCollection() {
  coll = db.collection('users');
}

emailcheck(email) async {
  var _val = await coll.findOne(where.eq("mail", email).fields(["password"]));
  return _val;
}

getUser(email) async {
  var _val = await coll.findOne(where.eq("mail", email));
  UserData currentUser = UserData(
    name: _val['name'],
    email: _val['mail'],
    photoUrl: _val['pic'],
    college: _val['college'],
  );
  return currentUser;
}
