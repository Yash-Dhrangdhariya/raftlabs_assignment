import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../../models/news_model.dart';
import '../../models/user_model.dart';
import '../../values/app_constants.dart';
import 'graphql_mutations.dart';
import 'graphql_queries.dart';

class GraphQLService {
  factory GraphQLService() => instance;

  GraphQLService._();

  static final instance = GraphQLService._();

  Future<UserModel?> getUsers(String userId) async {
    final result = await AppConstants.graphqlClient.query(
      queryGetUserById(userId: userId),
    );

    if (result.hasException) {
      log(result.exception.toString(), name: 'GraphQLService');
      throw Exception(result.exception);
    }

    if (result.data != null) {
      return UserModel.fromJson(
        result.data!['userById'] as Map<String, dynamic>,
      );
    }
    return null;
  }

  Future<List<NewsModel>> getNewsByUser(String userId) async {
    final result = await AppConstants.graphqlClient.query(
      queryGetNews(
        userId: userId,
        pollInterval: const Duration(seconds: 2),
      ),
    );

    if (result.hasException) {
      log(result.exception.toString(), name: 'GraphQLService');
      throw Exception(result.exception);
    }

    if (result.data != null) {
      final data = result.data!['getNewsByUser'] as List<dynamic>;
      final news = data
          .map(
            (e) => NewsModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();

      return news;
    }
    return [];
  }

  Future<void> postNews({required NewsModel news}) async {
    final result = await AppConstants.graphqlClient.mutate(
      mutationCreateNewsArticle(news: news),
    );

    if (result.hasException) {
      log(result.exception.toString(), name: 'GraphQLService');
      throw Exception(result.exception);
    }
  }

  /// for retrieving single user info by userID
  QueryOptions queryGetUserById({required String userId}) => QueryOptions(
        document: gql(GraphQLQueries().userById),
        variables: {
          'userId': userId,
        },
      );

  /// for retrieving list of news user is followings
  QueryOptions queryGetNews({
    required String userId,
    Duration? pollInterval,
  }) =>
      QueryOptions(
        document: gql(GraphQLQueries().getNews),
        variables: {
          'userId': userId,
        },
        pollInterval: pollInterval,
      );

  /// for retrieving list of users except current user
  QueryOptions queryGetUsersExcept({required String userId}) => QueryOptions(
        document: gql(GraphQLQueries().getUsersExcept),
        variables: {
          'exceptUser': userId,
        },
        pollInterval: const Duration(seconds: 2),
      );

  /// for adding user info into MongoDB
  MutationOptions mutationForCreateUser() => MutationOptions(
        document: gql(GraphQLMutations().createUserIfNotExist),
        update: (cache, result) => cache,
      );

  /// for adding news info into MongoDB
  MutationOptions mutationCreateNewsArticle({required NewsModel news}) =>
      MutationOptions(
        document: gql(GraphQLMutations().createNewsArticle),
        update: (cache, result) => cache,
        variables: {
          'author': news.author,
          'authorId': news.authorId,
          'title': news.title,
          'description': news.description,
          'image': news.image,
        },
      );

  /// for updating user info into MongoDB (ex. followings, news, followers)
  MutationOptions mutationForEditUser() => MutationOptions(
        document: gql(GraphQLMutations().followings),
        update: (cache, result) => cache,
      );
}
