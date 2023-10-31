import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../src/graphql/add_to_follow.graphql.dart';
import '../../src/graphql/get_all_users.graphql.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../values/app_client.dart';

part 'users_screen_store.g.dart';

class UsersScreenStore = _UsersScreenStore with _$UsersScreenStore;

abstract class _UsersScreenStore with Store {
  _UsersScreenStore() {
    fetchUsers();
  }

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Observable<QueryOnGetAllgetUsersExcept?>> users =
      ObservableList();

  @action
  Future<void> onTapFollow({
    required String receiverUserId,
  }) async {
    final currentUser = SharedPreferencesHelper.instance.getLoginUser();

    final results = await AppClient.client.mutateOnFollow(
      OptionsMutationOnFollow(
        variables: VariablesMutationOnFollow(
          sendingUserId: currentUser!.userId,
          receivingUserId: receiverUserId,
        ),
      ),
    );

    if (!results.hasException) {
      final data = results.parsedData!.addToFollow;
      users.firstWhere((element) => element.value?.userId == receiverUserId)
        ..value = QueryOnGetAllgetUsersExcept(
          $_id: data.$_id,
          name: data.name,
          userId: data.userId,
          email: data.email,
          avatar: data.avatar,
          news: data.news,
          followings: data.followings,
          followers: data.followers,
        )
        ..reportChanged();
    } else {
      log('Error: ${results.exception?.graphqlErrors}', name: 'OnTapFollow');
    }
  }

  Future<void> fetchUsers() async {
    isLoading = true;
    try {
      final result = await AppClient.client.queryOnGetAll(
        OptionsQueryOnGetAll(
          variables: VariablesQueryOnGetAll(
            exceptUser: SharedPreferencesHelper().getLoginUser()?.userId ?? '',
          ),
        ),
      );

      if (result.hasException) {
        log('Error: ${result.exception?.graphqlErrors}', name: 'Fetch Users');
      } else {
        if (result.parsedData?.getUsersExcept != null) {
          users = result.parsedData!.getUsersExcept!
              .map(Observable.new)
              .toList()
              .asObservable();
        }
      }
    } catch (e) {
      log('Error: $e', name: 'Fetch Users');
      throw Exception(e);
    } finally {
      isLoading = false;
    }
  }
}
