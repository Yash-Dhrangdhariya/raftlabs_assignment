import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart' hide Store;
import 'package:mobx/mobx.dart';
import 'package:raftlabs_assignment/models/news_model.dart';
import 'package:raftlabs_assignment/models/user_model.dart';
import 'package:raftlabs_assignment/services/graphql/graphql_queries.dart';
import 'package:raftlabs_assignment/services/graphql/graphql_service.dart';
import 'package:raftlabs_assignment/utils/data_helper.dart';
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
  bool isNewsLoading = false;

  @observable
  UserModel? currentUser;

  @observable
  ObservableList<NewsModel> news = ObservableList();

  Future<void> getNews() async {
    isNewsLoading = true;
    try {
      final watchGetNews = await AppConstants.graphqlClient.query(
        QueryOptions(
          document: gql(
            GraphQLQueries().getNews,
          ),
          variables: {
            'userId': currentUser?.userId ?? '',
          },
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic,
        ),
      );

      if (watchGetNews.data != null) {
        final data = DataHelper().toListOfNews(watchGetNews.data!);
        news = data.asObservable();
        isNewsLoading = false;
      }
    } catch (e) {
      AppConstants.showSnack('Oops! Something Went Wrong!');
      throw Exception(e);
    } finally {
      isNewsLoading = false;
    }
  }

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
      unawaited(getNews());
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
