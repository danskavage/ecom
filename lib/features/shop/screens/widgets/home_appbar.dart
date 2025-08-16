import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/appbar/appbar.dart';
import 'package:flutter_application_2/commons/widgets/products/cart/cart_menu_icon.dart';
import 'package:flutter_application_2/features/personalization/controllers/user_controller.dart';
import 'package:flutter_application_2/utils/constants/colors.dart';
import 'package:flutter_application_2/utils/constants/text_strings.dart';
import 'package:flutter_application_2/commons/widgets/shimmers/shimmer_loader.dart';
import 'package:get/get.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle,
              style: Theme.of(context) 
                  .textTheme
                  .labelMedium!
                  .apply(color: TColors.grey)),
          Obx((){
            if(controller.profileLoading.value){
              //display a shinner loader while user profile is being loaded
              return const TShimmerEffect(width:80,height:15);
            }else{
              return Text(controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: TColors.light));

            }
            
          }),
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: () {},
          iconColor: TColors.light,
        ),
      ],
    );
  }
}
