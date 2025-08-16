// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/controllers/expense_controller.dart';
// import 'package:get/get.dart';

// class ExpenseListingSection extends StatelessWidget {
//   ExpenseListingSection({super.key});

//   final controller = Get.find<ExpenseController>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 450,
//       width: 405,
//       margin: EdgeInsets.all(10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: const Color.fromARGB(255, 166, 138, 138),
//       ),
//       child: Obx(() {
//         return controller.isLoading.value
//             ? Center(child: CircularProgressIndicator(color: Colors.green))
//             : SingleChildScrollView(
//               child: Column(
//                 children:
//                     controller.expenses
//                         .map(
//                           (expense) => ListTile(
//                             leading: Icon(Icons.person, size: 25),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   expense.expenseAmount.toStringAsFixed(2),
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                                 SizedBox(width: 15),
//                                 IconButton(
//                                   icon: Icon(Icons.close, size: 25),
//                                   onPressed: () {
//                                     //final int expenseId  = controller.expenses.expenseId;
//                                     controller.deleteExpense(expense.id!);
//                                   },
//                                 ),
//                               ],
//                             ),

//                             //SizedBox(width: 5),
//                             title: Text(
//                               '${expense.id.toString()} ${expense.expenseName}',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                             subtitle: Text(
//                               expense.expenseCategory,
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                         )
//                         .toList(),

//                 //   mainAxisSize: MainAxisSize.min,
//                 //   children: [

//                 //   ],
//               ),
//             );
//       }),
//     );
//   }
// }
