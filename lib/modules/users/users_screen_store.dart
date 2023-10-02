import 'dart:developer';

// ignore: implementation_imports
import 'package:built_collection/src/list.dart';
import 'package:ferry/ferry.dart' hide Store;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';

import '../../src/graphql/__generated__/add_to_follow.req.gql.dart';
import '../../src/graphql/__generated__/get_all_users.data.gql.dart';
import '../../src/graphql/__generated__/get_all_users.req.gql.dart';
import '../../src/graphql/__generated__/get_all_users.var.gql.dart';

part 'users_screen_store.g.dart';

class UsersScreenStore = _UsersScreenStore with _$UsersScreenStore;

abstract class _UsersScreenStore with Store {
  _UsersScreenStore() {
    fetchUsers();
  }

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Observable<GGetAllUsersData_getUsersExcept?>> users =
      ObservableList();

  void listen(
    OperationResponse<GGetAllUsersData, GGetAllUsersVars> value,
  ) {
    log('Data: ${value.data}', name: 'Listen');
    if (value.data != null) {
      users = value.data!.getUsersExcept!
          .map(Observable.new)
          .toList()
          .asObservable();
    }
  }

  @action
  Future<void> onTapFollow({
    required String receiverUserId,
  }) async {
    final currentUser = SharedPreferencesHelper.instance.getLoginUser();
    Modular.get<TypedLink>()
        .request(
      GAddToFollowReq(
        (b) => b
          ..vars.receivingUserId = receiverUserId
          ..vars.sendingUserId = currentUser?.userId,
      ),
    )
        .listen((event) {
      if (event.data != null) {
        final data = event.data!.addToFollow;

        users.firstWhere((element) => element.value?.userId == receiverUserId)
          ..value = GGetAllUsersData_getUsersExcept(
            (b) => b
              ..userId = data.userId
              ..followers = ListBuilder(data.followers.map((p0) => p0))
              ..followings = ListBuilder(data.followings.map((p0) => p0))
              ..name = data.name
              ..avatar = data.avatar
              ..email = data.email
              ..G_id = data.G_id
              ..G__typename = data.G__typename,
          )
          ..reportChanged();
      }
    });
  }

  Future<void> fetchUsers() async {
    isLoading = true;
    try {
      Modular.get<TypedLink>()
          .request(
            GGetAllUsersReq(
              (b) => b.vars.exceptUser =
                  SharedPreferencesHelper().getLoginUser()?.userId ?? '',
            ),
          )
          .listen(listen);
    } catch (e) {
      log('Error: $e', name: 'Fetch Users');
      throw Exception(e);
    } finally {
      isLoading = false;
    }
  }
}
