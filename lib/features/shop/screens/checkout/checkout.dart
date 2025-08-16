import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/appbar/appbar.dart';
import 'package:flutter_application_2/commons/widgets/common_shapes/containers/rounded_container.dart';
import 'package:flutter_application_2/commons/widgets/products/cart/coupon.dart';
import 'package:flutter_application_2/commons/widgets/success_screen/success_screen.dart';
import 'package:flutter_application_2/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:flutter_application_2/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:flutter_application_2/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:flutter_application_2/navigation_menu.dart';
import 'package:flutter_application_2/utils/constants/colors.dart';
import 'package:flutter_application_2/utils/constants/image_strings.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';
import 'package:flutter_application_2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Order Review',
            style: Theme.of(context).textTheme.headlineSmall,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //items in cart
              const TCartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              //coupon textfield
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              //billing system
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    //pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    //divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    //payment methods

                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    //address
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => SuccessScreen(
                  image: TImages.mpesa,
                  title: 'payment Success!',
                  subtitle: 'Your item will be shipped soon!',
                  onPressed: () => Get.offAll(() => const NavigationMenu()),
                )),
            child: const Text('Checkout Ksh750')),
      ),
    );
  }
}
