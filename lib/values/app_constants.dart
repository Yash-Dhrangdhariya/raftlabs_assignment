import 'package:flutter/material.dart';

class AppConstants {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static const graphqlBaseURL =
      'https://angry-eel-wetsuit.cyclic.cloud/graphql';

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
      ),
    );
}
