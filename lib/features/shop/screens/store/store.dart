import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/appbar/appbar.dart';
import 'package:flutter_application_2/commons/widgets/appbar/tabbar.dart';
import 'package:flutter_application_2/commons/widgets/common_shapes/containers/search_container.dart';
import 'package:flutter_application_2/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_application_2/commons/widgets/products/cart/cart_menu_icon.dart';
import 'package:flutter_application_2/commons/widgets/brands/brand_card.dart';
import 'package:flutter_application_2/commons/widgets/texts/section_heading.dart';
import 'package:flutter_application_2/features/shop/controllers/category_controller.dart';
import 'package:flutter_application_2/features/shop/screens/brands/all_brands.dart';
import 'package:flutter_application_2/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter_application_2/utils/constants/colors.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';
import 'package:flutter_application_2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //search bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      //Featured brands
                      TSectionHeading(
                          title: 'Featured Brands',
                          onPressed: () =>
                              Get.to(() => const AllBrandsScreen())),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      TGridLayout(
                          itemCounter: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return const TBrandCard(
                              showBorder: false,
                            );
                          })
                    ],
                  ),
                ),

                //Tabs
                bottom: TTabBar(
                  tabs: categories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories
                .map((category) => TCategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
