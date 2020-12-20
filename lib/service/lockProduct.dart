import 'package:BookFinder/service/dbConfig.dart';
import 'package:mongo_dart/mongo_dart.dart';

lockProduct(category, id, currentUserMail) async {
  var coll = db.collection(category);
  var v = await coll.findOne(where.eq('id', id));
  v['Locked'] = true;
  v['LockedBy'] = currentUserMail;
  await coll.save(v);
}
