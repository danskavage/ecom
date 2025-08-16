import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/category_controller.dart';
import 'package:flutter_application_2/controllers/expense_controller.dart';
import 'package:get/get.dart';

class CategoryExpensePage extends StatelessWidget {
  CategoryExpensePage({super.key, required this.category});

  final String category;
  final controller = Get.find<ExpenseController>();
  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$category expenses")),
      body: Obx(() {
        final filterdExpenses =
            controller.expenses
                .where((expense) => expense.expenseCategory == category)
                .toList();
        if (filterdExpenses.isEmpty) {
          return Center(child: Text("No expenses for this category"));
        }
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator(color: Colors.green))
            : SingleChildScrollView(
              child: Column(
                children:
                    filterdExpenses
                        .map(
                          (expense) => ListTile(
                            leading: Icon(Icons.person, size: 25),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  expense.expenseAmount.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: 15),
                                IconButton(
                                  icon: Icon(Icons.close, size: 25),
                                  onPressed: () {
                                    //final int expenseId  = controller.expenses.expenseId;
                                    controller.deleteExpense(expense.id!);
                                    categoryController.loadCategoryTotals();
                                  },
                                ),
                              ],
                            ),

                            //SizedBox(width: 5),
                            title: Text(
                              '${expense.id.toString()} ${expense.expenseName}',
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              category,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                        .toList(),

                //   mainAxisSize: MainAxisSize.min,
                //   children: [

                //   ],
              ),
            );
      }),
    );
  }
}
