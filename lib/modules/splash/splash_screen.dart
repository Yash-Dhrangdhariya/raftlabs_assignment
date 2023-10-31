import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_screen_store.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final _store = Modular.get<HomeScreenStore>();

  @override
  Widget build(BuildContext context) {
    _store.getUser();
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }
}
