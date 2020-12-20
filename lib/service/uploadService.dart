import 'package:BookFinder/models/user.dart';
import 'package:BookFinder/service/dbConfig.dart';
import 'package:uuid/uuid.dart';

var coll;

getCollection(thing) {
  coll = db.collection(thing);
}

upload(UserData currentUser, picUrl, title) async {
  var id = Uuid().v4();
  await coll.insert(
    {
      'id': id,
      'mail': currentUser.email,
      'title': title,
      'imageUrl': picUrl,
      'nameOfUser': currentUser.name,
      'college': currentUser.college,
      'Locked': false,
      'LockedBy': '',
    },
  );
}
