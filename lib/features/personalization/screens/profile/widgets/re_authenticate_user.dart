import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/personalization/controllers/user_controller.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';
import 'package:flutter_application_2/utils/constants/text_strings.dart';
import 'package:flutter_application_2/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateForm extends StatelessWidget {
  const ReAuthenticateForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(TSizes.defaultSpace) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //email
              TextFormField(
                controller: controller.verifyEmail,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right),labelText: TTexts.email),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              //password

              Obx( ()=>
                 TextFormField(
                  obscureText: controller.hidePassword.value,
                  controller: controller.verifyPassword,
                  validator: (value) => TValidator.validateEmptyText('Password', value),
                  decoration:  InputDecoration(prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(onPressed: ()=> controller.hidePassword.value = !controller.hidePassword.value, icon: const Icon(Iconsax.eye_slash)),
                  labelText: TTexts.password),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections,),

              //LogIn Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()=> controller.reAuthenticateEmailAndPasswordUser(),
                  child: const Text('Verify')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
