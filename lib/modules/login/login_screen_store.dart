import 'package:ferry/ferry.dart' hide Store;
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:raftlabs_assignment/services/authentication/google_service.dart';
import 'package:raftlabs_assignment/src/graphql/__generated__/create_user.req.gql.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';

import '../../src/graphql/__generated__/create_user.data.gql.dart';
import '../../values/app_routes.dart';

part 'login_screen_store.g.dart';

class LoginScreenStore = _LoginScreenStore with _$LoginScreenStore;

abstract class _LoginScreenStore with Store {
  @observable
  bool isSignIn = false;

  Future<void> signIn() async {
    isSignIn = true;
    try {
      GCreateUserData_createUserIfNotExists? user;
      if (kIsWeb) {
        final data = await GoogleService().signInWithGoogleWeb();
        user = data;
      } else {
        final data = await GoogleService().signInWithGoogle();
        user = data;
      }
      if (user != null) {
        await SharedPreferencesHelper.instance.setLoginUser(
          user,
        );
        Modular
          ..get<TypedLink>().request(
            GCreateUserReq(
              (b) => b.vars
                ..userId = user?.userId
                ..email = user?.email
                ..avatar = user?.avatar
                ..name = user?.name,
            ),
          )
          ..to.navigate(AppRoutes.splashScreen);
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      isSignIn = false;
    }
  }
}
