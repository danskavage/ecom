import 'package:flutter_application_2/models/expense_model.dart';
import 'package:flutter_application_2/repositories/expense_repo.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository _repo = ExpenseRepository();

  var expenses = <Expense>[].obs;
  var isLoading = false.obs;
  var totalExpensee = 0.0.obs;
  var remainAmount = 0.0.obs;

  // var categoryTotals = <String, double>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
    //totalExpense();
  }

  Future<void> loadExpenses() async {
    isLoading.value = true;
    final data = await _repo.getExpenses();
    expenses.assignAll(data);
    print('fetched ${data.length} expenses');
    await totalExpense();
    //await loadCategoryTotals();
    await remainingAmount();

    isLoading.value = false;
  }

  Future<void> totalExpense() async {
    totalExpensee.value = await _repo.totalExpenses();
    print("Total Expenses are: $totalExpensee");
  }

  Future<void> addExpense(Expense expense) async {
    await _repo.addExpense(expense);
    await remainingAmount();
    await totalExpense();
    //after adding data load the expesnes again
    await loadExpenses();
  }

  Future<void> remainingAmount() async {
    final amount = await _repo.remainingAmount();
    remainAmount.value = amount;
    await totalExpense();
  }

  Future<void> deleteExpense(int id) async {
    await _repo.deleteExpense(id);

    await totalExpense();
    await loadExpenses();
    await remainingAmount();
    //after deleting load he expenses again
  }

  Future<void> deleteExpenseRecords() async {
    await _repo.deleteExpenseRecords();
    await loadExpenses();
    await remainingAmount();
  }

  // Future<void> loadCategoryTotals() async {
  //   final totals = await _repo.fetchCategoryTotals();
  //   print("The fetched categoryTotals are $totals");
  //   categoryTotals.value = totals;
  // }
}
