import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'utils/shared_preferences_helper.dart';
import 'values/app_constants.dart';
import 'values/app_routes.dart';
import 'values/app_themes.dart';

class SocialMediaNewsApp extends StatelessWidget {
  const SocialMediaNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper.instance.getLoginUser() == null
        ? Modular.setInitialRoute(Modular.initialRoute)
        : Modular.setInitialRoute(AppRoutes.splashScreen);
    return MaterialApp.router(
      title: 'Social Media News App',
      theme: AppThemes.lightTheme,
      scaffoldMessengerKey: AppConstants.scaffoldMessengerKey,
      routerConfig: Modular.routerConfig,
    );
  }
}
