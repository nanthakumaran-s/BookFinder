import 'package:BookFinder/service/dbConfig.dart';
import 'package:mongo_dart/mongo_dart.dart';

var coll;

getCollection() {
  coll = db.collection('users');
}

updateName(email, name) async {
  var v1 = await coll.findOne(where.eq("mail", email));
  v1["name"] = name;
  await coll.save(v1);
}
