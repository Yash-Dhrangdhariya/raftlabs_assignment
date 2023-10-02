import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../src/graphql/__generated__/create_user.data.gql.dart';
import 'shared_preferences_keys.dart';

class SharedPreferencesHelper {
  factory SharedPreferencesHelper() => instance;

  const SharedPreferencesHelper._(this.prefs);

  final SharedPreferences prefs;

  static late final SharedPreferencesHelper instance;

  static Future<void> initialize() async =>
      instance = SharedPreferencesHelper._(
        await SharedPreferences.getInstance(),
      );

  Future<void> setLoginUser(GCreateUserData_createUserIfNotExists user) async {
    await prefs.setString(
      PrefKeys.kUserInfo,
      jsonEncode(user.toJson()),
    );
  }

  GCreateUserData_createUserIfNotExists? getLoginUser() {
    return (prefs.getString(PrefKeys.kUserInfo)?.isNotEmpty ?? false)
        ? GCreateUserData_createUserIfNotExists.fromJson(
            jsonDecode(prefs.getString(PrefKeys.kUserInfo) ?? '')
                as Map<String, dynamic>,
          )
        : null;
  }

  Future<void> clear() async {
    await prefs.remove(PrefKeys.kUserInfo);
    await prefs.clear();
  }
}
