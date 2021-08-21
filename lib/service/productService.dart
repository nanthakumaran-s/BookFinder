import 'package:BookFinder/models/product.dart';
import 'package:BookFinder/service/dbConfig.dart';
import 'package:mongo_dart/mongo_dart.dart';

var coll;

getCollection(category) {
  coll = db.collection(category);
}

getObjects(collegeName, product, mail) async {
  await coll.find(where.eq("college", collegeName)).forEach((v) {
    if (v['Locked'] == false && v['mail'] != mail) {
      product.add(Product.from(
        v['id'],
        v['mail'],
        v['title'],
        v['imageUrl'],
        v['nameOfUser'],
        v['college'],
        v['locked'],
        v['lockedBy'],
      ));
    }
  });
}
