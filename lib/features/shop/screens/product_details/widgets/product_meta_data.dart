import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/common_shapes/containers/rounded_container.dart';
import 'package:flutter_application_2/commons/widgets/images/t_circular_image.dart';
import 'package:flutter_application_2/commons/widgets/texts/product_price_text.dart';
import 'package:flutter_application_2/commons/widgets/texts/product_title_text.dart';
import 'package:flutter_application_2/commons/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:flutter_application_2/features/shop/models/product_models.dart';
import 'package:flutter_application_2/utils/constants/colors.dart';
import 'package:flutter_application_2/utils/constants/enums.dart';
import 'package:flutter_application_2/utils/constants/image_strings.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key,required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //price and sale price
        Row(
          children: [
            //sale tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text('25%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black)),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            //price
            Text('Ksh 500',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),

            const SizedBox(width: TSizes.spaceBtwItems),

            const TProductPriceText(
              price: '750',
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //title
        const TProductTitleText(title: 'Green Nike Sports Shirt'),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //stock status

        Row(
          children: [
            const TProductTitleText(title: 'Status'),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //brand

        const Row(
          children: [
            TCircularImage(image: TImages.cosmeticsIcon),
            TBrandTitlewithVerifiedIcon(
                title: 'Nike', brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}
