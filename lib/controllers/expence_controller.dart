import 'package:get/get.dart';
import '../models/transaction_model.dart';
import '../database/sqlite.dart';

class ExpenceController extends GetxController {
  var expenses = <TransactionModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  void addExpense(TransactionModel expense) async {
    await DataBaseHelper.insertExpense(expense);
    loadExpenses();
    update();
  }

  void loadExpenses() async {
    expenses.value = await DataBaseHelper.getALLexpences();
  }

  //compute total balance(income - expenses)
  double get totalBalance => totalIncome - totalExpenses;

  //compute total Expenses
  double get totalExpenses => expenses
      .where((e) => e.type == 'expense')
      .fold(0, (sum, e) => sum + e.amount);

  //compute total income
  double get totalIncome => expenses
      .where((e) => e.type == 'income')
      .fold(0, (sum, e) => sum + e.amount);

  // recent transactions (last:5 , sorted by date)

  List<TransactionModel> get recentTransactions =>
      (expenses.toList()..sort((a, b) => b.date.compareTo(a.date)))
          .take(5)
          .toList();

  //this monts expenses

  double get thisMonthExpenses {
    final now = DateTime.now();
    return expenses
        .where(
          (e) =>
              e.type == 'expense' &&
              e.date.year == now.year &&
              e.date.month == now.month,
        )
        .fold(0, (sum, e) => sum + e.amount);
  }
}
