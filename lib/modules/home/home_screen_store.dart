import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

import '../../src/graphql/__generated__/get_user.data.gql.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../values/app_routes.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  @observable
  GGetUserData_userById? user;

  // ignore: use_setters_to_change_properties
  void initializeUser(GGetUserData_userById? value) {
    if (value == null) {
      Modular.to.navigate(Modular.initialRoute);
    } else {
      user = value;
      Modular.to.navigate(AppRoutes.homeScreen);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await SharedPreferencesHelper.instance.clear();
    Modular
      ..dispose()
      ..setInitialRoute(Modular.initialRoute)
      ..to.navigate(
        Modular.initialRoute,
      );
  }
}
