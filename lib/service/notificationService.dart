import 'package:firebase_storage/firebase_storage.dart';
import 'package:BookFinder/constants/strings.dart';
import 'package:BookFinder/models/lockedProduct.dart';
import 'package:BookFinder/screens/Home.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'dbConfig.dart';

var coll;

init(mail) async {
  lockedProducts.clear();
  await getLockedProduct(mail, CommonStrings.books);
  await getLockedProduct(mail, CommonStrings.stationary);
}

getLockedProduct(mail, collection) async {
  coll = db.collection(collection);
  await coll.find(where.eq('mail', mail)).forEach((v) {
    if (v['Locked'] == true) {
      lockedProducts.add(
        LockedProduct(
          id: v['id'],
          title: v['title'],
          lockedBy: v['LockedBy'],
          imageUrl: v['imageUrl'],
          category: collection,
        ),
      );
    }
  });
}

userAccepted(id, category, url) async {
  StorageReference storageReference =
      await FirebaseStorage.instance.getReferenceFromUrl(url);
  await storageReference.delete().then((_) => print('Deleted'));
  coll = db.collection(category);
  coll.remove(where.eq('id', id));
}

userRejected(id, category) async {
  coll = db.collection(category);
  var v = await coll.findOne(where.eq('id', id));
  v["Locked"] = false;
  v['LockedBy'] = '';
  await coll.save(v);
}
