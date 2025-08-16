import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/income_model.dart';
import 'package:flutter_application_2/repositories/income_repo.dart';
import 'package:get/get.dart';

class IncomeController extends GetxController {
  final IncomeRepository _repo = IncomeRepository();
  final incomeValue = TextEditingController();
  var totalIncome = 0.00.obs;
  var remainAmount = 0.0.obs;

  var incomes = <Income>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadIncomes();
  }

  Future<void> loadIncomes() async {
    isLoading.value = true;
    final data = await _repo.getIncomes();
    print('fetched ${data.length} incomes');
    incomes.assignAll(data);
    isLoading.value = false;
    totalIncome.value = await _repo.totalIncome();
    print("Total incomes are: ${totalIncome.value}");
  }

  Future<void> addIncome(Income income) async {
    await _repo.addIncome(income);
    print('adding $income to the database');
    //after adding data load the expesnes again
    await loadIncomes();
    await remainingAmount();
  }

  Future<void> deleteIncomeRecords() async {
    await _repo.deleteIncomeRecords();
    await loadIncomes();
    await remainingAmount();
  }

  Future<void> remainingAmount() async {
    final amount = await _repo.remainingAmount();
    remainAmount.value = amount;
    await loadIncomes();
  }

  // Future<void> deleteCategory(int id) async {
  //   await _repo.deleteCategory(id);
  //   //after deleting load he expenses again
  //   await loadCategories();
  // }
}
