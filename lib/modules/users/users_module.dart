import 'package:flutter_modular/flutter_modular.dart';

import 'users_screen.dart';
import 'users_screen_store.dart';

class UsersModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<UsersScreenStore>(
      UsersScreenStore.new,
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => UsersScreen(),
    );
  }
}
