// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/category_controller.dart';
import 'package:flutter_application_2/controllers/expense_controller.dart';
import 'package:flutter_application_2/controllers/income_controller.dart';

import 'package:flutter_application_2/models/income_model.dart';
import 'package:get/get.dart';

class AmountInitSection extends StatelessWidget {
  AmountInitSection({super.key});

  final controller = Get.find<ExpenseController>();
  final incomeController = Get.find<IncomeController>();
  final categoryController = Get.find<CategoryController>();

  //final double income = 0.00;

  @override
  Widget build(BuildContext context) {
    var incomeTotal = incomeController.totalIncome;

    var expenseTotal = controller.totalExpensee;

    var remAmount = controller.remainAmount;

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 255, 255, 0.2),
      ),

      child: Column(
        children: [
          //const SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: incomeController.incomeValue,
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    labelText: 'Add Income',
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    filled: true,
                    fillColor: Colors.white60,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white12, width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if (incomeController.incomeValue.text.isNotEmpty) {
                    incomeController.addIncome(
                      Income(
                        incomeAmount:
                            double.tryParse(
                              incomeController.incomeValue.text,
                            ) ??
                            0.0,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter an amount")),
                    );
                    return;
                  }

                  controller.remainingAmount();
                  incomeController.incomeValue.clear();
                  FocusScope.of(context).unfocus();
                },
                child: Text('Add Income'),
              ),
              SizedBox(width: 5),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Card(
                  color: const Color.fromARGB(255, 2, 184, 123),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text('TOTAL INCOME'),
                      Obx(() => Text('Ksh $incomeTotal')),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Card(
                  color: const Color.fromARGB(255, 222, 2, 108),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text('TOTAL EXPENSE'),
                      Obx(() => Text("Ksh $expenseTotal")),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.blueGrey,
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'REMAINING INCOME',
                        style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() => Text('Ksh $remAmount')),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
