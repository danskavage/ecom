import 'package:flutter_application_2/data/repostories/categories/category_repository.dart';
import 'package:flutter_application_2/features/shop/models/category_model.dart';
import 'package:flutter_application_2/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  //load category data
  Future<void> fetchCategories() async {
    try {
      //show loader while loading categories
      isLoading.value = true;
      //fetch categories from data source
      final categories = await _categoryRepository.getAllCategories();

      //update the categories list
      allCategories.assignAll(categories);

      //filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //remove loader
      isLoading.value = false;
    }
  }
}
