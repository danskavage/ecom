import 'package:flutter/material.dart';
import 'package:flutter_application_2/app_sections/amountInitSection.dart';
import 'package:flutter_application_2/app_sections/category_display_section.dart';
import 'package:flutter_application_2/app_sections/pie_chart_section.dart';
import 'package:flutter_application_2/controllers/category_controller.dart';
import 'package:flutter_application_2/controllers/expense_controller.dart';
import 'package:flutter_application_2/controllers/income_controller.dart';
import 'package:flutter_application_2/dialogs/add_category_dialogbox.dart';
import 'package:flutter_application_2/dialogs/add_expense_dialogbox.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final controller = Get.find<ExpenseController>();
  final categoryController = Get.find<CategoryController>();
  final incomeController = Get.find<IncomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.amberAccent, fontSize: 20),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.2),
      ),
      //const Color.fromARGB(255, 2, 43, 37)
      backgroundColor: const Color.fromARGB(255, 1, 35, 30),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AmountInitSection(),
            CategoryDisplay(),
            PieChartDisplay(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 59, 109, 109),
                //foregroundColor: const Color.fromARGB(255, 243, 41, 1),
                elevation: 0,
              ),
              label: Text(
                "Reset",
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              icon: Icon(
                Icons.delete,
                color: const Color.fromARGB(255, 218, 127, 1),
              ),

              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text("Delete All Records"),
                        content: Text(
                          "Are you sure you want to delete all records?",
                        ),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      181,
                                      200,
                                      218,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      32,
                                      42,
                                      46,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await controller.deleteExpenseRecords();
                                    await incomeController
                                        .deleteIncomeRecords();
                                    await categoryController
                                        .deleteCategoryRecords();

                                    // await incomeController.loadIncomes();
                                    // await controller.loadExpenses();
                                    await controller.remainingAmount();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        254,
                                        254,
                                        254,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 2, 78, 104),
              foregroundColor: const Color.fromARGB(255, 0, 255, 119),
            ),
            onPressed: () {
              showExpenseDialogBox(context);
            },
            child: Text('Add Expense'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.orange,
            ),
            onPressed: () {
              showCategoryDialogBox(context);
            },
            child: Text('Add Category'),
          ),
          //////this extra button should nbe removed later /////////////////
          // TextButton(
          //   style: TextButton.styleFrom(
          //     backgroundColor: Colors.black87,
          //     foregroundColor: Colors.orange,
          //   ),
          //   onPressed: () {
          //     controller.addExpense(
          //       Expense(
          //         expenseName: "Nyakoe",
          //         expenseAmount: 50,
          //         expenseCategory: "transport",
          //       ),
          //     );
          //     //categoryController.categories.add(Category(categoryName: "transport"));
          //     controller.remainingAmount();
          //     categoryController.loadCategoryTotals();
          //   },
          //   child: Text('Trouble'),
          // ),

          //////this extra button should nbe removed later /////////////////
        ],
      ),
    );
  }
}
