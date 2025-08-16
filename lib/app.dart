import 'package:flutter_application_2/bindings/general_bindings.dart';
import 'package:flutter_application_2/routes/app_routes.dart';
import 'package:flutter_application_2/utils/constants/colors.dart';
import 'package:flutter_application_2/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Use this class to setup themes, initial binding, and animations
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,

      //show loader or circular progress indicator meanwhile authentication reponsitory is deciding to show relevant screen,
      home: const Scaffold(backgroundColor:TColors.primary,body:Center(child:CircularProgressIndicator(color:Colors.white))),
    );
  }
}
