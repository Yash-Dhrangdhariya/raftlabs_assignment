import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uuid/uuid.dart';

import 'app_colors.dart';

class AppConstants {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static const uuid = Uuid();

  static const graphqlBaseURL =
      'https://angry-eel-wetsuit.cyclic.cloud/graphql';

  static final graphqlClient = GraphQLClient(
    link: HttpLink(graphqlBaseURL),
    cache: GraphQLCache(),
  );

  static void showSnack(String message) => scaffoldMessengerKey.currentState
    ?..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
    );
}
