import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/common_shapes/containers/primary_header_container.dart';
import 'package:flutter_application_2/commons/widgets/common_shapes/containers/search_container.dart';
import 'package:flutter_application_2/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_application_2/commons/widgets/products/product_cards/product_card_vertical.dart';
import 'package:flutter_application_2/commons/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:flutter_application_2/commons/widgets/texts/section_heading.dart';
import 'package:flutter_application_2/features/shop/controllers/product/product_contrroller.dart';
import 'package:flutter_application_2/features/shop/screens/widgets/home_appbar.dart';
import 'package:flutter_application_2/features/shop/screens/widgets/home_categories.dart';
import 'package:flutter_application_2/features/shop/screens/widgets/promo_slider.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //search bar
                  TSearchContainer(text: 'Search in Store'),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        //heading
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        //categoriessss
                        THomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ),

            //body of home screen
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //promo slider
                  const TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //heading
                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () {},
                    // => Get.to(() =>  const AllProductsScreen(product:))
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //popular products

                  Obx(() {
                    if (controller.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                          child: Text('No Data Found!',
                              style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return TGridLayout(
                        itemCounter: controller.featuredProducts.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                            product: controller.featuredProducts[index]));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
