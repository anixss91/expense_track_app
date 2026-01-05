import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),

        // GetPage(name: '/Add' ,page: => AddTransactionScreen),
      ],
    );
  }
}
