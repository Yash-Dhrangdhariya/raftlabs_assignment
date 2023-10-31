import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'values/app_routes.dart';

class AppModules extends Module {
  @override
  void routes(RouteManager r) {
    r
      ..module(
        Modular.initialRoute,
        module: LoginModule(),
      )
      ..module(
        AppRoutes.homeScreen,
        module: HomeModule(),
      );
  }
}
