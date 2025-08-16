import 'package:flutter_application_2/models/category_model.dart';
import 'package:flutter_application_2/repositories/category_repo.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final CategoryRepository _repo = CategoryRepository();

  var categories = <Category>[].obs;
  var isLoading = false.obs;
  ////// fIND OUT WHAT KIND OF VARIABLE THIS IS AND HOW TO ADD AND REMOVE VALUES FROM IT(suspect iys an object)/////////////{
  var categoryTotals = <String, double>{}.obs;
  ////// fIND OUT WHAT KIND OF VARIABLE THIS IS AND HOW TO ADD AND REMOVE VALUES FROM IT(suspect iys an object)/////////////

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    isLoading.value = true;
    final data = await _repo.getCategories();
    categories.assignAll(data);
    print("Loaded Categories: ${categories.length}");
    await loadCategoryTotals();
    isLoading.value = false;
  }

  Future<void> addCategory(Category category) async {
    await _repo.addCategory(category);
    //after adding data load the expesnes again
    await loadCategories();
  }

  Future<void> deleteCategory(int id) async {
    await _repo.deleteCategory(id);
    //after deleting load he expenses again
    String categoryName =
        categories.firstWhere((category) => category.id == id).categoryName;
    categoryTotals.remove(categoryName);
    categoryTotals.refresh();

    print("Deleted category name is: $categoryName");
    await loadCategories();
  }

  Future<void> deleteCategoryRelatedExpenses(String category) async {
    await _repo.deleteCategoryRelatedExpenses(category);
    await loadCategoryTotals();
  }

  Future<void> deleteCategoryRecords() async {
    await _repo.deleteCategoryRecords();
    await loadCategories();
    await loadCategoryTotals();
  }

  Future<void> loadCategoryTotals() async {
    final totals = await _repo.fetchCategoryTotals();
    print("The fetched categoryTotals are $totals");
    categoryTotals.value = totals;
    //await loadCategories();
  }
}
