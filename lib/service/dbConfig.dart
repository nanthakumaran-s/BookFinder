import 'package:mongo_dart/mongo_dart.dart';

var db;

connectDB() async {
  db =
      await Db.create('Your DB name'); //TODO: Copy paste your MongoDB Atlas url
  try {
    await db.open(secure: true);
    print("connected");
  } catch (err) {
    print(err);
  }
}
