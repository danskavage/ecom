import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repostories/authentication/authentication_repo.dart';
import 'package:flutter_application_2/features/authentication/models/network_manager.dart';
import 'package:flutter_application_2/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:flutter_application_2/utils/constants/image_strings.dart';
import 'package:flutter_application_2/utils/popups/full_screen_loarder.dart';
import 'package:flutter_application_2/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //send reset pswd email
  sendPasswordResetEmail() async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.onBoardingImage3);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //send email to reser pswd
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email);

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoaders.successSnackBar(
          title: 'Email sent',
          message: 'Email link sent to Reset your Password');

      //redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }


//send email to reset password

  resendPasswordResetEmail(String email) async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.onBoardingImage3);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
     
      //send email to reser pswd
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email as TextEditingController);

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoaders.successSnackBar(
          title: 'Email sent',
          message: 'Email link sent to Reset your Password'.tr);

      //redirect
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
}
