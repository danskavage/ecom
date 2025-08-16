import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/products/cart/add_remove_button.dart';
import 'package:flutter_application_2/commons/widgets/products/cart/cart_item.dart';
import 'package:flutter_application_2/commons/widgets/texts/product_price_text.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) =>
          const SizedBox(height: TSizes.spaceBtwSections),
      itemCount: 14,
      itemBuilder: (_, index) => Column(
        children: [
          //cart item
          const TCartItem(),
          if (showAddRemoveButtons)
            const SizedBox(height: TSizes.spaceBtwItems),

          //add , remove buttons row with total price
          if (showAddRemoveButtons)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 70),
                    TProductQuantityAddandRemoveButton(),
                  ],
                ),
                TProductPriceText(price: '750'),
              ],
            )
        ],
      ),
    );
  }
}
