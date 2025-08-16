import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/appbar/appbar.dart';
import 'package:flutter_application_2/commons/widgets/brands/brand_card.dart';
import 'package:flutter_application_2/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_application_2/commons/widgets/texts/section_heading.dart';
import 'package:flutter_application_2/features/shop/screens/brands/brand_products.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(children: [
                //heading
                const TSectionHeading(
                  title: 'Brands',
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                //Brands
                TGridLayout(
                  itemCounter: 10,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) => TBrandCard(
                    showBorder: true,
                    onTap: () => Get.to(() => const BrandProducts()),
                  ),
                ),
              ]))),
    );
  }
}
