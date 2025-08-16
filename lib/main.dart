import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/category_controller.dart';
import 'package:flutter_application_2/controllers/expense_controller.dart';
import 'package:flutter_application_2/controllers/income_controller.dart';

import 'package:flutter_application_2/screens/main_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());

  Get.put(ExpenseController());
  Get.put(CategoryController());
  Get.put(IncomeController());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: MainScreen());
  }
}
