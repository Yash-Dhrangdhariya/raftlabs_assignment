import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../values/app_routes.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/news_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: NewsView(),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'users',
            onPressed: () async {
              await Modular.to.pushNamed(
                AppRoutes.usersScreen,
              );
            },
            child: const Icon(Icons.person_search),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: 'create',
            onPressed: () => Modular.to.pushNamed(
              AppRoutes.postNewsScreen,
            ),
            child: const Icon(Icons.create),
          ),
        ],
      ),
    );
  }
}
