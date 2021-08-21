import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/service/dbConfig.dart';
import 'package:mongo_dart/mongo_dart.dart';

var coll;

getCollection() {
  coll = db.collection('users');
}

emailcheck(email) async {
  var _val = await coll.findOne(where.eq("mail", email));
  return _val != null ? true : false;
}

uploaduser(name, email, collegeName, password, photoUrl) async {
  try {
    await coll.insert(
      {
        'name': name,
        'mail': email,
        'college': collegeName,
        'password': password,
        'pic': photoUrl
      },
    );
    UserData currentUser = UserData(
      name: name,
      email: email,
      college: collegeName,
      photoUrl: photoUrl,
    );
    return currentUser;
  } catch (err) {
    print(err);
  }
}
