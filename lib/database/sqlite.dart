import 'package:flutter/rendering.dart';
import '../models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    
    final path = join(await getDatabasesPath(), 'expenses.db');
    
    _db = await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE expenses('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'amount REAL NOT NULL, '
          'category TEXT NOT NULL, '
          'type TEXT NOT NULL, '
          'date TEXT NOT NULL'
          ')',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute('ALTER TABLE expenses ADD COLUMN category TEXT DEFAULT "General"');
        }
      },
    );
    return _db!;
  }

  static Future<bool> insertExpense(TransactionModel expense) async {
    try {
      final db = await getDatabase();
      await db.insert('expenses', expense.toMap());
      return true;
    } catch (e) {
      debugPrint('Insert failed: $e');
      return false;
    }
  }

  static Future<List<TransactionModel>> getALLexpences() async {
    try {
      final db = await getDatabase();
      final maps = await db.query('expenses');
      return maps.map((e) => TransactionModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Read failed: $e');
      return [];
    }
  }
}