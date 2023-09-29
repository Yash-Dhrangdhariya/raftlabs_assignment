import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:raftlabs_assignment/models/user_model.dart';
import 'package:raftlabs_assignment/services/graphql/graphql_service.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';
import 'package:raftlabs_assignment/values/app_constants.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  _HomeScreenStore() {
    getUser();
  }

  @observable
  bool isLoading = false;

  @observable
  UserModel? currentUser;

  Future<void> getUser() async {
    isLoading = true;
    try {
      final user = await GraphQLService().getUsers(
        SharedPreferencesHelper.instance.getLoginUser()?.userId ?? '',
      );
      currentUser = user;
    } catch (e) {
      AppConstants.showSnack('Service Unavailable!');
      throw Exception(e);
    } finally {
      isLoading = false;
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
