import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:raftlabs_assignment/modules/home/widgets/home_app_bar.dart';
import 'package:raftlabs_assignment/modules/home/widgets/news_view.dart';
import 'package:raftlabs_assignment/values/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          NewsView(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'search',
            onPressed: () => Modular.to.pushNamed(
              AppRoutes.usersScreen,
            ),
            child: const Icon(Icons.search),
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
