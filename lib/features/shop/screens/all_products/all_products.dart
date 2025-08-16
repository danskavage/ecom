import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/appbar/appbar.dart';
import 'package:flutter_application_2/features/shop/models/product_models.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';

class AllProductsScreen extends StatelessWidget {
  final ProductModel product;

  const AllProductsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(title: Text('Popular Products'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          //child: TSortableProducts(product: ProductModel.empty()),
        ),
      ),
    );
  }
}
