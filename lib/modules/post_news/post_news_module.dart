import 'package:flutter_modular/flutter_modular.dart';
import 'package:raftlabs_assignment/modules/post_news/post_news_screen.dart';
import 'package:raftlabs_assignment/modules/post_news/post_news_screen_store.dart';

class PostNewsModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<PostNewsScreenStore>(
      PostNewsScreenStore.new,
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => PostNewsScreen(),
    );
  }
}
