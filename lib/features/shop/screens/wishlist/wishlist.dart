import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/appbar/appbar.dart';
import 'package:flutter_application_2/commons/widgets/icons/t_circular_icon.dart';
import 'package:flutter_application_2/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_application_2/commons/widgets/products/product_cards/product_card_vertical.dart';
import 'package:flutter_application_2/features/shop/models/product_models.dart';
import 'package:flutter_application_2/features/shop/screens/home/home.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(  const HomeScreen())
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(
                  itemCounter: 10,
                  itemBuilder: (_, index) => TProductCardVertical(product: ProductModel.empty())),
            ],
          ),
        ),
      ),
    );
  }
}
