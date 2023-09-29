import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';
import 'package:raftlabs_assignment/values/app_constants.dart';
import 'package:raftlabs_assignment/values/app_routes.dart';
import 'package:raftlabs_assignment/values/app_themes.dart';

class RaftLabsAssignment extends StatelessWidget {
  const RaftLabsAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper.instance.getLoginUser() == null
        ? Modular.setInitialRoute(Modular.initialRoute)
        : Modular.setInitialRoute(AppRoutes.splashScreen);
    return MaterialApp.router(
      title: 'RaftLabs Assignment',
      theme: AppThemes.lightTheme,
      scaffoldMessengerKey: AppConstants.scaffoldMessengerKey,
      routerConfig: Modular.routerConfig,
    );
  }
}
