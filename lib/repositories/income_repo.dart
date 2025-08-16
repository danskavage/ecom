import 'package:flutter_application_2/models/income_model.dart';
import 'package:flutter_application_2/sqlite_database/database_service.dart';

class IncomeRepository {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<List<Income>> getIncomes() async {
    final data = await _dbService.fetchIncomes();
    return data.map((e) => Income.fromMap(e)).toList();
  }

  Future<void> addIncome(Income income) async {
    await _dbService.insertIncome(income.toMap());
  }

  Future<double> totalIncome() async {
    return await _dbService.getTotalIncome();
  }

  Future<double> remainingAmount() async {
    return await _dbService.getRemainingAmount();
  }

  Future<void> deleteIncomeRecords() async {
    await _dbService.deleteIncomeRecords();
  }

  // Future<void> deleteCategory(int id) async {
  //   await _dbService.deleteCategory(id);
  // }
}
