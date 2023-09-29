import 'package:flutter_modular/flutter_modular.dart';
import 'package:raftlabs_assignment/modules/post_news/post_news_module.dart';
import 'package:raftlabs_assignment/modules/splash/splash_screen.dart';
import 'package:raftlabs_assignment/modules/users/users_screen.dart';

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
      ..child(
        '/users/',
        child: (context) => const UsersScreen(),
      );
  }

  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeScreenStore>(
      HomeScreenStore.new,
    );
  }
}
