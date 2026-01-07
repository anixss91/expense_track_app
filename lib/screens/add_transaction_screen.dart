import 'package:flutter/material.dart';
import '../controllers/expence_controller.dart';
import '../models/transaction_model.dart';
import 'package:get/get.dart';

class AddTransactionScreen extends StatelessWidget {
  final ExpenceController controller = Get.find();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final RxString selectedType = 'expense'
      .obs; //start with expense when the value change the UI will rebuild

  AddTransactionScreen({
    super.key,
  }); //start with expense when the value change the UI will rebuild

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
        backgroundColor: Color(0xFF9333EA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              height: 80,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFe5E7EB), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount ',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '\$ 0.00',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFD1D5DB),
                      ),
                    ),
                    style: TextStyle(fontSize: 24, color: Color(0xFFD1D5DB)),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE5E7EB), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type ',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                  SizedBox(height: 12),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => selectedType.value = 'expense',
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: selectedType.value == 'expense'
                                    ? Color(0xFFDC2626).withOpacity(0.1)
                                    : Color(0xFFF3F4F6),
                                border: selectedType.value == 'expense'
                                    ? Border.all(
                                        color: Color(0xFFDC2626),
                                        width: 2,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'expense',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: selectedType.value == 'expense'
                                        ? Color(0xFFDC2626)
                                        : Color(0xFF6B7280),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => selectedType.value = 'income',
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: selectedType.value == 'income'
                                    ? Color(0xFFDC2626).withOpacity(0.1)
                                    : Color(0xFFF3F4F6),
                                border: selectedType.value == 'income'
                                    ? Border.all(
                                        color: Color(0xFFDC2626),
                                        width: 2,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  'Income',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: selectedType.value == 'expense'
                                        ? Color(0xFFDC2626)
                                        : Color(0xFF6B7280),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9333EA), Color(0xFF2563EB)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    final transaction = TransactionModel(
                      amount: double.parse(amountController.text),
                      category: categoryController.text.isNotEmpty
                          ? categoryController.text
                          : 'General',
                      date: DateTime.now(),
                      type: selectedType.value,
                    );
                    controller.addExpense(transaction);
                    Get.back();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
