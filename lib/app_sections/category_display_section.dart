import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/category_controller.dart';
import 'package:flutter_application_2/controllers/expense_controller.dart';
import 'package:flutter_application_2/screens/category_expense_page.dart';
import 'package:get/get.dart';

class CategoryDisplay extends StatelessWidget {
  CategoryDisplay({super.key});

  final controller = Get.find<CategoryController>();
  final expenseController = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 255, 255, 0.2),
      ),
      child: Obx(() {
        if (controller.categories.isEmpty) {
          Center(child: Text("No categories Added Yet"));
        } else {
          return controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: Colors.green))
              : SingleChildScrollView(
                child: Wrap(
                  spacing: 4,
                  runSpacing: 2,

                  children:
                      controller.categories
                          .map(
                            (category) => Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(130, 40),
                                    elevation: 0,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 10,
                                    ),
                                    // padding: EdgeInsets.symmetric(
                                    //   horizontal: -5,
                                    //   vertical: 0,
                                    // ),
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      55,
                                      84,
                                      99,
                                    ),
                                    foregroundColor: Colors.white,
                                  ),
                                  // onLongPress: () {
                                  //   controller.deleteCategory(category.id!);
                                  // },
                                  onPressed: () {
                                    Get.to(
                                      () => CategoryExpensePage(
                                        category: category.categoryName,
                                      ),
                                    );
                                  },

                                  child: Row(
                                    //mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.category, size: 10),
                                      SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          category.categoryName,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      //SizedBox(width: 10),
                                      Expanded(
                                        child: IconButton(
                                          style: IconButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: 0,
                                            ),
                                          ),
                                          onPressed: () async {
                                            await controller.deleteCategory(
                                              category.id!,
                                            );
                                            await controller
                                                .deleteCategoryRelatedExpenses(
                                                  category.categoryName,
                                                );
                                            await expenseController
                                                .loadExpenses();
                                            //await expenseController.deleteExpense();
                                            //await controller.loadCategoryTotals();
                                          },
                                          icon: Icon(Icons.delete, size: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(width: 8),
                              ],
                            ),
                          )
                          .toList(),
                ),
              );
        }
        return Center(child: Text("No Categories Added"));
      }),
    );
  }
}
