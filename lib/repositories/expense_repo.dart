import 'package:flutter_application_2/models/expense_model.dart';
import 'package:flutter_application_2/sqlite_database/database_service.dart';

class ExpenseRepository {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<List<Expense>> getExpenses() async {
    final data = await _dbService.fetchExpenses();
    return data.map((e) => Expense.fromMap(e)).toList();
  }

  Future<void> addExpense(Expense expense) async {
    await _dbService.insertExpense(expense.toMap());
    await getExpenses();
  }

  Future<double> totalExpenses() async {
    return await _dbService.getTotalExpenses();
  }

  Future<double> remainingAmount() async {
    return await _dbService.getRemainingAmount();
  }

  Future<void> deleteExpense(int id) async {
    await _dbService.deleteExpense(id);
    await getExpenses();
  }

  Future<void> deleteExpenseRecords() async {
    await _dbService.deleteExpenseRecords();
  }

  //below method is for getting the totals by category from the database
  Future<Map<String,double>> fetchCategoryTotals()async{
    return await _dbService.getCategoryTotals();
  }
}
