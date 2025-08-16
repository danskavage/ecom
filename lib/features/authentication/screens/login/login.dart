import 'package:flutter_application_2/commons/styles/spacing_style.dart';
import 'package:flutter_application_2/commons/widgets/login_signup/form_divider.dart';
import 'package:flutter_application_2/commons/widgets/login_signup/social_buttons.dart';
import 'package:flutter_application_2/features/authentication/screens/login/widgets/login_form.dart';
import 'package:flutter_application_2/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter_application_2/utils/constants/sizes.dart';
import 'package:flutter_application_2/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //logo title and subtitle
              const TLoginHeader(),

              //form
              const TLoginForm(),

              //divider

              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),

              const SizedBox(height: TSizes.spaceBtwSections),
              //footer
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
