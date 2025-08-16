import 'package:flutter_application_2/models/category_model.dart';
import 'package:flutter_application_2/sqlite_database/database_service.dart';

class CategoryRepository {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<List<Category>> getCategories() async {
    final data = await _dbService.fetchCategories();
    return data.map((e) => Category.fromMap(e)).toList();
  }

  Future<void> addCategory(Category category) async {
    await _dbService.insertCategory(category.toMap());
  }

  Future<void> deleteCategory(int id) async {
    await _dbService.deleteCategory(id);
  }

  Future<void> deleteCategoryRelatedExpenses(String category) async {
    await _dbService.deleteCategoryRelatedExpenses(category);
    await getCategories();
    await fetchCategoryTotals();
  }

  Future<void> deleteCategoryRecords() async {
    await _dbService.deleteCategoryRecords();
  }

  //below method is for getting the totals by category from the database
  Future<Map<String, double>> fetchCategoryTotals() async {
    return await _dbService.getCategoryTotals();
  }
}
