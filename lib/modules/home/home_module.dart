import 'package:flutter_modular/flutter_modular.dart';

import '../post_news/post_news_module.dart';
import '../splash/splash_screen.dart';
import '../users/users_module.dart';
import 'home_screen.dart';
import 'home_screen_store.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (context) => const HomeScreen(),
      )
      ..child(
        '/splash/',
        child: (context) => SplashScreen(),
      )
      ..module(
        '/post/',
        module: PostNewsModule(),
      )
      ..module(
        '/users/',
        module: UsersModule(),
      );
  }

  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeScreenStore>(
      HomeScreenStore.new,
    );
  }
}
