import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/brands/brand_showcase.dart';
import 'package:flutter_application_2/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_application_2/commons/widgets/products/product_cards/product_card_vertical.dart';
import 'package:flutter_application_2/commons/widgets/texts/section_heading.dart';
import 'package:flutter_application_2/features/shop/models/category_model.dart';
import 'package:flutter_application_2/features/shop/models/product_models.dart';
import 'package:flutter_application_2/utils/constants/image_strings.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //brands
              const TBrandShowcase(
                images: [
                  TImages.productImage1,
                  TImages.productImage2,
                  TImages.productImage3,
                ],
              ),
              const TBrandShowcase(
                images: [
                  TImages.productImage3,
                  TImages.productImage2,
                  TImages.productImage1,
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              //products
              TSectionHeading(
                title: 'You might like',
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TGridLayout(
                  itemCounter: 4,
                  itemBuilder: (_, index) => TProductCardVertical(product: ProductModel.empty())),

              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
