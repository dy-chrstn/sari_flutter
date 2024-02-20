import 'dart:developer';

import 'package:logger/logger.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:sari/dbHelper/constant.dart';
import 'package:sari/model/business_acc_model.dart';

class MongoDatabase {
  static Db? db;
  static late DbCollection businessCollection;

  static Future<void> connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db!.open();
    inspect(db);
    businessCollection = db!.collection(BUSINESS_COLLECTION);
  }

  static Future<String> insert(BusinessAcc data) async {
    try {
      await connect(); // Ensure the database connection is established before inserting

      var result = await businessCollection.insertOne(data.toJson());

      if (result.isSuccess) {
        Logger().d('Data Inserted Successfully');
        return 'Data Inserted Successfully';
      } else {
        Logger().d('Something went Wrong');
        return 'Something went Wrong';
      }
    } catch (e) {
      Logger().d(e.toString());
      return e.toString();
    }
  }
}
