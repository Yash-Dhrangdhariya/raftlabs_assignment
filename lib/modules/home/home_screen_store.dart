import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

import '../../src/graphql/get_user.graphql.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../values/app_client.dart';
import '../../values/app_routes.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  @observable
  QueryOnGetUseruserById? user;

  // ignore: use_setters_to_change_properties
  void initializeUser(QueryOnGetUseruserById? value) {
    if (value == null) {
      Modular.to.navigate(Modular.initialRoute);
    } else {
      user = value;
      Modular.to.navigate(AppRoutes.homeScreen);
    }
  }

  Future<void> getUser() async {
    final result = await AppClient.client.queryOnGetUser(
      OptionsQueryOnGetUser(
        variables: VariablesQueryOnGetUser(
          userId: SharedPreferencesHelper.instance.getLoginUser()?.userId ?? '',
        ),
      ),
    );

    if (result.hasException) {
      log('Error: ${result.exception?.graphqlErrors}');
      Modular.to.navigate(Modular.initialRoute);
    } else {
      if (result.parsedData?.userById == null) {
        Modular.to.navigate(Modular.initialRoute);
      } else {
        user = result.parsedData?.userById;
        Modular.to.navigate(AppRoutes.homeScreen);
      }
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
