import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:raftlabs_assignment/modules/home/home_screen_store.dart';
import 'package:raftlabs_assignment/values/app_routes.dart';

class SplashScreen extends StatelessObserverWidget {
  SplashScreen({super.key});

  final _store = Modular.get<HomeScreenStore>();

  @override
  Widget build(BuildContext context) {
    if (!_store.isLoading) {
      if (_store.currentUser != null) {
        Modular.to.navigate(AppRoutes.homeScreen);
      } else {
        Modular.to.navigate(Modular.initialRoute);
      }
    }
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }
}
