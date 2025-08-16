import 'package:flutter_application_2/data/repostories/banners/banner_repository.dart';
import 'package:flutter_application_2/features/shop/models/banner_models.dart';
import 'package:flutter_application_2/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  //variables
  final carouselCurrentIndex = 0.obs;
  //final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  //update page navigatoin dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  //fetch banners
  Future<void> fetchBanners() async {
    try {
      //show loader while loading categories
      isLoading.value = true;

      //fetch banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      //assign banners
      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //remove loader
      isLoading.value = false;
    }
  }
}
