import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/appbar/appbar.dart';
import 'package:flutter_application_2/commons/widgets/products/ratings/rating_indicator.dart';
// ignore: unused_import
import 'package:flutter_application_2/features/shop/screens/product_reviews/widgets/progree_indicator_and_rating.dart';
import 'package:flutter_application_2/features/shop/screens/product_reviews/widgets/ratting_progress_indicator.dart';
import 'package:flutter_application_2/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: const TAppBar(
        title: Text('Review & Ratings'),
        showBackArrow: true,
      ),

      //body

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Rating and reviews are verified and are from people who use the same type of device that you use.'),
              const SizedBox(height: TSizes.spaceBtwItems),

              //ovarall product rating
              const TOverallProducRating(),
              const TRatingBarIndicator(
                rating: 3.5,
              ),
              Text(
                '12,611',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //user review list
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
