import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/category_controller.dart';
import 'package:flutter_application_2/models/category_model.dart';
import 'package:get/get.dart';

void showCategoryDialogBox(BuildContext context) {
  final TextEditingController categoryController = TextEditingController();
  final CategoryController controller = Get.find<CategoryController>();
  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          title: Center(child: Text('Add Category')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
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
                      categoryController.clear();
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
                      final String categoryName = categoryController.text;
                      if (categoryController.text.trim().isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please enter a Category Name',
                          backgroundColor: Colors.blueGrey,
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          icon: Icon(Icons.check_circle, color: Colors.white),
                          shouldIconPulse: true,
                        );
                        return;
                      }
                      controller.addCategory(
                        Category(categoryName: categoryName),
                      );

                      print('Added Category $categoryName to the list');
                      categoryController.clear();
                      Navigator.pop(context);
                      Get.snackbar(
                        'Category added',
                        'You have added $categoryName successfully',
                        // titleText: Text('Expense Added'),
                        // messageText:Text(''),
                        duration: Duration(seconds: 1),
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(Icons.check_circle, color: Colors.green),
                        shouldIconPulse: true,
                        backgroundColor: Colors.green,
                        colorText: Colors.black,
                      );
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
