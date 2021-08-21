import 'package:mongo_dart/mongo_dart.dart';

var db;

connectDB() async {
  db = await Db.create(
      'mongodb+srv://riyazur:razak@cluster0.gvwny.mongodb.net/bookfinder?retryWrites=true&w=majority');
  try {
    await db.open(secure: true);
    print("connected");
  } catch (err) {
    print(err);
  }
}
