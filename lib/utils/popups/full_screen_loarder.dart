import 'package:flutter/material.dart';
import 'package:flutter_application_2/commons/widgets/loaders/animation_loader.dart';
import 'package:flutter_application_2/utils/constants/colors.dart';
import 'package:flutter_application_2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context:
            Get.overlayContext!, //use get.overlaycontext for overlay dialogs
        barrierDismissible: false, //dialog cant be dismissed
        builder: (_) => PopScope(
            canPop: false, //disable popping with the back button
            child: Container(
              color: THelperFunctions.isDarkMode(Get.context!)
                  ? TColors.dark
                  : TColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250), //adjust the spacing
                  TAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
            )));

  
  }
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop(); //close the dialog using the navigator
  }
}
