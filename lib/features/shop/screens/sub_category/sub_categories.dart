import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/appbar/appbar.dart';
import 'package:flutter_application_2/commons/widgets/images/t_rounded_image.dart';
import 'package:flutter_application_2/commons/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:flutter_application_2/commons/widgets/texts/section_heading.dart';
import 'package:flutter_application_2/utils/constants/image_strings.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppBar(
        title: Text('Sports shirts'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //banner
              const TRoundedImage(
                width: double.infinity,
                imageUrl: TImages.promoBanner3,
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              //sub-categories
              Column(
                children: [
                  //heading
                  TSectionHeading(title: 'Sports shirts',onPressed: (){}),
                  const SizedBox(height: TSizes.spaceBtwItems/2),
                  SizedBox(
                    height:120,
                  
                     child: ListView.separated(
                      itemCount:6,
                      separatorBuilder:(context,index)=>const SizedBox(width:TSizes.spaceBtwItems),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) => const TProductCardHorizontal(),
                     )
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
