import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/category_controller.dart';
import 'package:flutter_application_2/controllers/expense_controller.dart';
import 'package:flutter_application_2/models/category_model.dart';

import 'package:flutter_application_2/models/expense_model.dart';
import 'package:get/get.dart';

void showExpenseDialogBox(BuildContext context) {
  final controller = Get.find<ExpenseController>();
  final categoryController = Get.find<CategoryController>();

  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();
  // final TextEditingController expenseCategoryController =
  //     TextEditingController();
  String? selectedValue;

  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          title: Center(child: Text('Add Expense')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: expenseNameController,
                decoration: InputDecoration(
                  labelText: 'Expense Name',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: expenseAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Expense Amount',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // TextField(
              //   controller: expenseCategoryController,
              //   decoration: InputDecoration(
              //     labelText: 'Expense Category',
              //     labelStyle: TextStyle(color: Colors.black),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black, width: 1),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black, width: 1),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              // ),

              ////DROPDOWN MENU HERE IF DOESNT WORK REMOVE LATER////
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                value: selectedValue,
                items:
                    categoryController.categories.map((Category category) {
                      return DropdownMenuItem(
                        value: category.categoryName,
                        child: Text(category.categoryName),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  selectedValue = newValue;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Select a Category for the Expense';
                  }
                  return null;
                },
              ),

              //////    DROPDOWN ENDS HERE //////////
              ///
              SizedBox(height: 10),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 79, 79, 78),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      expenseNameController.clear();
                      expenseAmountController.clear();
                      //expenseCategoryController.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 7),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 4, 179, 138),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      final String expenseName = expenseNameController.text;

                      final double expenseAmount =
                          double.tryParse(
                            expenseAmountController.text.trim(),
                          ) ??
                          0.00;
                      final String expenseCategory = selectedValue!;

                      if (expenseNameController.text.trim().isEmpty) {
                        Get.snackbar(
                          'error',
                          'Please Enter Expense Name',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.blueGrey,
                          colorText: Colors.white,
                          icon: Icon(Icons.check_circle, color: Colors.white),
                          shouldIconPulse: true,
                        );
                        return;
                      }
                      ///////BELOW CODE IF TO VALIDATE THE EXPENSECTEGORY TEXTFIELD IF ITS EMPTY ////////

                      // if (expenseCategoryController.text.trim().isEmpty) {
                      //   Get.snackbar(
                      //     'Error',
                      //     'Pleae enter Expense Category',
                      //     snackPosition: SnackPosition.BOTTOM,
                      //     snackStyle: SnackStyle.FLOATING,
                      //     backgroundColor: Colors.blueGrey,
                      //     colorText: Colors.white,
                      //     icon: Icon(Icons.check_circle, color: Colors.white),
                      //     shouldIconPulse: true,
                      //   );
                      //   return;
                      // }

                      ///////////// END OF EXPENSECATEGORY VALIDATION  ///////////
                      controller.addExpense(
                        Expense(
                          expenseName: expenseName,
                          expenseAmount: expenseAmount,
                          expenseCategory: expenseCategory,
                        ),
                      );
                      categoryController.loadCategoryTotals();

                      // Get.back();

                      print(
                        'The following has been saved to the expense list $expenseName , $expenseAmount and $expenseCategory',
                      );
                      print(controller.expenses.length);
                      expenseNameController.clear();
                      expenseAmountController.clear();
                      //expenseCategoryController.clear();
                      Navigator.pop(context);
                      Get.snackbar(
                        'Expense added',
                        'You have added $expenseName costing $expenseAmount for category $expenseCategory',
                        // titleText: Text('Expense Added'),
                        // messageText:Text(''),
                        duration: Duration(seconds: 2),
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(Icons.check_circle, color: Colors.green),
                        shouldIconPulse: true,
                        backgroundColor: Colors.green,
                        colorText: Colors.black,
                      );

                      // Get.defaultDialog(
                      //   title: 'Expense Added',
                      //   middleText:
                      //       'You have added $expenseName costing $expenseAmount for category $expenseCategory',
                      //   textCancel: 'Cancel',
                      //   textConfirm: 'Ok',
                      //   confirmTextColor: Colors.white,
                      //   onConfirm: () => Get.back(),
                      //   onCancel: () => Get.back(),
                      // );
                    },
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
          ],
        ),
  );
}
