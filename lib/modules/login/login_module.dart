import 'package:flutter_modular/flutter_modular.dart';

import 'login_screen.dart';
import 'login_screen_store.dart';

class LoginModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => LoginScreen(),
    );
  }

  @override
  void binds(Injector i) {
    i.addLazySingleton<LoginScreenStore>(
      LoginScreenStore.new,
    );
  }
}
