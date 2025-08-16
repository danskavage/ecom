import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/data/repostories/authentication/authentication_repo.dart';
import 'package:flutter_application_2/features/authentication/models/network_manager.dart';
import 'package:flutter_application_2/features/personalization/controllers/user_controller.dart';
import 'package:flutter_application_2/utils/constants/image_strings.dart';
import 'package:flutter_application_2/utils/popups/full_screen_loarder.dart';
import 'package:flutter_application_2/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL');
    password.text = localStorage.read('REMEMBER_ME_EMAIL_PASSWORD');
    super.onInit();
  }

  //email and password signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.onBoardingImage2);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //form validater
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_EMAIL_PASSWORD', password.text.trim());
      }

      //login using email and pswd
      //final userCredentials = 
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //remove loader
      TFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      //remove loader
      TFullScreenLoader.stopLoading();

      //show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // ..... google sinin authentication

  Future<void> googleSignIn() async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.onBoardingImage3);

      //check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //google authentication
      final userCredentials =
          AuthenticationRepository.instance.signInWithGoogle();
          
      //save user records
      await userController.saveUserRecord(userCredentials as UserCredential?);

      //remove loader
      TFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
