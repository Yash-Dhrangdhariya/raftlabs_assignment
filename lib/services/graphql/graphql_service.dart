import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:raftlabs_assignment/models/news_model.dart';
import 'package:raftlabs_assignment/models/user_model.dart';
import 'package:raftlabs_assignment/values/app_constants.dart';

class GraphQLService {
  factory GraphQLService() => instance;

  GraphQLService._();

  static final instance = GraphQLService._();

  Future<UserModel?> getUsers(String userId) async {
    final result = await AppConstants.graphqlClient.query(
      getCurrentUser(userId),
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
      queryGetNews(userId),
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

  Future<void> postNews(NewsModel news) async {
    final result = await AppConstants.graphqlClient.mutate(
      createNews(news),
    );

    if (result.hasException) {
      log(result.exception.toString(), name: 'GraphQLService');
      throw Exception(result.exception);
    }
  }

  MutationOptions createUser() => MutationOptions(
        document: gql(
          r'''
          mutation CreateUserIfNotExists($name: String!, $userId: String!, $email: String!, $avatar: String!) {
            createUserIfNotExists(name: $name, userId: $userId, email: $email, avatar: $avatar) {
              _id
              name
              userId
              email
              avatar
              news
              followings
              followers
            }
          }
        ''',
        ),
        update: (cache, result) => cache,
        onCompleted: (dynamic resultData) {
          debugPrint(resultData.toString());
        },
      );

  MutationOptions createNews(NewsModel news) => MutationOptions(
        document: gql(
          r'''
          mutation CreateNewsArticle($author: String!, $authorId: String!, $title: String!, $description: String!, $image: String!) {
            createNewsArticle(author: $author, authorId: $authorId, title: $title, description: $description, image: $image) {
              _id
              author
              title
              description
              image
              authorId
              publishedAt
            }
          }
        ''',
        ),
        update: (cache, result) => cache,
        onCompleted: (dynamic resultData) {
          debugPrint(resultData.toString());
        },
        variables: {
          'author': news.author,
          'authorId': news.authorId,
          'title': news.title,
          'description': news.description,
          'image': news.image,
        },
      );

  QueryOptions getCurrentUser(String userId) => QueryOptions(
        document: gql(
          r'''
          query Query($userId: String!) {
            userById(userId: $userId) {
              _id
              name
              userId
              email
              avatar
              news
              followings
              followers
            }
          }
          ''',
        ),
        variables: {
          'userId': userId,
        },
      );

  QueryOptions queryGetNews(String userId) => QueryOptions(
        document: gql(
          r'''
          query GetNews($userId: String!) {
            getNews(userId: $userId) {
              _id
              author
              title
              description
              image
              authorId
              publishedAt
            }
          }
          ''',
        ),
        variables: {
          'userId': userId,
        },
        pollInterval: const Duration(seconds: 2),
      );

  QueryOptions queryForGetExceptUser(String userId) => QueryOptions(
        document: gql(
          r'''
          query GetUsersExcept($exceptUser: String!) {
            getUsersExcept(exceptUser: $exceptUser) {
              _id
              name
              userId
              email
              avatar
              news
              followings
              followers
            }
          }
          ''',
        ),
        variables: {
          'exceptUser': userId,
        },
        pollInterval: const Duration(seconds: 2),
      );

  MutationOptions mutationForEditUser({
    required String senderId,
    required String receiverId,
  }) =>
      MutationOptions(
        document: gql(
          r'''
         mutation Followings($sendingUserId: String!, $receivingUserId: String!) {
           followings(sendingUserId: $sendingUserId, receivingUserId: $receivingUserId)
         }
          ''',
        ),
      );
}
