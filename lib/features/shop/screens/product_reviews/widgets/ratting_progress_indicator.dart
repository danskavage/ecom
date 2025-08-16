import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/shop/screens/product_reviews/widgets/progree_indicator_and_rating.dart';

class TOverallProducRating extends StatelessWidget {
  const TOverallProducRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 3,
        child: Text(
          '4.8',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      const Expanded(
        flex: 7,
        child: Column(
          children: [
            TRatingProgressIndicator(text: '5', value: 1.0),
            TRatingProgressIndicator(text: '4', value: 0.8),
            TRatingProgressIndicator(text: '3', value: 0.6),
            TRatingProgressIndicator(text: '2', value: 0.4),
            TRatingProgressIndicator(text: '1', value: 0.2),
          ],
        ),
      ),
    ]);
  }
}
