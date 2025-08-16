import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repostories/authentication/authentication_repo.dart';
import 'package:flutter_application_2/data/repostories/user/user_model.dart';
import 'package:flutter_application_2/data/repostories/user/user_repository.dart';
import 'package:flutter_application_2/features/authentication/models/network_manager.dart';
import 'package:flutter_application_2/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:flutter_application_2/utils/constants/image_strings.dart';
import 'package:flutter_application_2/utils/popups/full_screen_loarder.dart';
import 'package:flutter_application_2/utils/popups/loaders.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController(); //controller for email input
  final lastName = TextEditingController(); //controller for lastname input
  final userName = TextEditingController(); //controller for username input
  final password = TextEditingController(); //controller for password input
  final firstName = TextEditingController(); //controller for firstname input
  final phoneNumber =
      TextEditingController(); //controller for phonenumber input

  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); //form key for form validation

  //SIGNUP
  void signup() async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog('We are processing your infomation..',
          TImages.onBoardingImage2); //should be changed to animation

      //check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //privacy policy check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must read and accept the Privacy Policy & Terms of use,',
        );
        return;
      }

      //register user in the firebase authentication and save user data in the firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      //save authenticated user data in the firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success messgae
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');

      //move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      //remove loader
      TFullScreenLoader.stopLoading();

      //show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
  