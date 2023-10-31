import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../services/authentication/google_service.dart';
import '../../src/graphql/create_user.graphql.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../values/app_routes.dart';

part 'login_screen_store.g.dart';

class LoginScreenStore = _LoginScreenStore with _$LoginScreenStore;

abstract class _LoginScreenStore with Store {
  @observable
  bool isSignIn = false;

  Future<void> signIn() async {
    isSignIn = true;
    try {
      MutationUsercreateUserIfNotExists? user;
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
        Modular.to.navigate(AppRoutes.splashScreen);
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      isSignIn = false;
    }
  }
}
