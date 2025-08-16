import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repostories/user/user_repository.dart';
import 'package:flutter_application_2/features/authentication/models/network_manager.dart';
import 'package:flutter_application_2/features/personalization/controllers/user_controller.dart';
import 'package:flutter_application_2/features/personalization/screens/profile/profile.dart';
import 'package:flutter_application_2/utils/constants/image_strings.dart';
import 'package:flutter_application_2/utils/popups/full_screen_loarder.dart';
import 'package:flutter_application_2/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  //init user data when home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //fetch user record

  Future<void> initializeNames() async {
    firstname.text = userController.user.value.firstName;
    lastname.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information...', TImages.onBoardingImage3);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //update users first and last name in the firebase firestore
      Map<String, dynamic> name = {
        'FirstName': firstname.text.trim(),
        'LastName': lastname.text.trim()
      };
      await userRepository.updateSingleField(name);

      //update the Rx user value
      userController.user.value.firstName = firstname.text.trim();
      userController.user.value.lastName = lastname.text.trim();

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');

      //move to previous screen
      Get.offAll(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
