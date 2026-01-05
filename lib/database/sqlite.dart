import 'package:flutter/rendering.dart';

import '../models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static Database?
  _db; //static means shared by ther whole app and _means private variale(singleton db)

  //getter method to access the db
  static Future<Database> getDatabase() async {
    if (_db != null) return _db!; //! means sure its not null
    //get the database path
    final path = join(await getDatabasesPath(), 'expenses.db' /*file Name*/);
    //create the db
    _db = await openDatabase(
      path,

      version: 1,
      onCreate: (db, version) async {
        //create the table
        await db.execute(
          'CREATE TABLE expanses('
          'id INTEGER PRIMARY KEY ,'
          'amount REAL,'
          'category TEXT,'
          'date TEXT'
          '),',
        );
      },
    );
    return _db!;
  }

  //insert expence
  static Future<bool> insertExpense(TransactionModel expense) async {
    try {
      final db = await getDatabase();
      await db.insert('expenses', expense.toMap());
      return true;
    } catch (e) {
      debugPrint('Insert failed :$e');
      return false;
    }
  }

  //get Expence

  static Future<List<TransactionModel>> getALLexpences() async {
    try {
      final db = await getDatabase();
      final maps = await db.query('expenses');
      return maps.map((e) => TransactionModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Read failed : $e');
      return [];
    }
  }
}
