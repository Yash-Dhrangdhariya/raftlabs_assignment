import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../src/graphql/__generated__/get_user.req.gql.dart';
import '../../utils/shared_preferences_helper.dart';
import '../home/home_screen_store.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final _store = Modular.get<HomeScreenStore>();

  @override
  Widget build(BuildContext context) {
    return Operation(
      client: Modular.get<TypedLink>(),
      operationRequest: GGetUserReq(
        (b) => b.vars.userId =
            SharedPreferencesHelper.instance.getLoginUser()?.userId,
      ),
      builder: (context, response, error) {
        if (response?.data != null) {
          _store.initializeUser(response!.data?.userById);
        }
        return const Scaffold(
          body: Center(
            child: FlutterLogo(
              size: 200,
            ),
          ),
        );
      },
    );
  }
}
