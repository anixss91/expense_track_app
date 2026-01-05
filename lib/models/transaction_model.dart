import 'package:intl/intl.dart';

class TransactionModel {
  int? id;
  double amount;
  String category;
  DateTime date;
  String type;
  TransactionModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'amount': amount,
    'category': category,
    'type': type,
    'date': date
        .toIso8601String(), //Returns an ISO-8601 full-precision extended format representation.
    //output: 1969-07-20T20:18:04.000Z
  };
  //convert the Map into Object

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      type: map['type'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }
}
