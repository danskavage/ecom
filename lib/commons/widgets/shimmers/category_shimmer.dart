import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/shimmers/shimmer_loader.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) =>
                const SizedBox(width: TSizes.spaceBtwItems),
            itemCount: itemCount,
            itemBuilder: (_, __) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TShimmerEffect(width: 55, height: 55, radius: 55),
                  SizedBox(height: TSizes.spaceBtwItems / 2),

                  //text
                  TShimmerEffect(width: 55, height: 8),
                ],
              );
            }));
  }
}
