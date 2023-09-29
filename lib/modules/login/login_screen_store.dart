import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:raftlabs_assignment/models/user_model.dart';
import 'package:raftlabs_assignment/services/authentication/google_service.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';

part 'login_screen_store.g.dart';

class LoginScreenStore = _LoginScreenStore with _$LoginScreenStore;

abstract class _LoginScreenStore with Store {
  @observable
  bool isSignIn = false;

  Future<UserModel?> signIn() async {
    isSignIn = true;
    try {
      UserModel? user;
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
      }
      return user;
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      isSignIn = false;
    }
  }
}
