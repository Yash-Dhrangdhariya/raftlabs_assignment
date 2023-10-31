import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../src/graphql/create_user.graphql.dart';
import '../../values/app_client.dart';
import '../../values/app_constants.dart';

class GoogleService {
  factory GoogleService() => instance;

  GoogleService._();

  static final instance = GoogleService._();

  Future<MutationUsercreateUserIfNotExists?> signInWithGoogle() async {
    /// start auth process
    final currentUser = await GoogleSignIn().signIn();

    /// Obtain the auth details from the request
    final googleAuth = await currentUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );

    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final data = await createUser(
        userId: userCredential.user?.uid ?? '',
        email: userCredential.user?.email ?? '',
        avatar: userCredential.user?.photoURL ?? '',
        name: userCredential.user?.displayName ?? '',
      );
      return data;
    } catch (e) {
      AppConstants.showSnack('Service Unavailable.');
      log(
        'Error: $e',
        name: 'Google Service (WEB)',
      );
      throw Exception(e);
    }
  }

  Future<MutationUsercreateUserIfNotExists?> signInWithGoogleWeb() async {
    final authProvider = GoogleAuthProvider();
    try {
      final userCredential = await FirebaseAuth.instance.signInWithPopup(
        authProvider,
      );
      final firebaseUser = userCredential.user;
      final data = await createUser(
        userId: firebaseUser?.uid ?? '',
        email: firebaseUser?.email ?? '',
        avatar: firebaseUser?.photoURL ?? '',
        name: firebaseUser?.displayName ?? '',
      );
      return data;
    } catch (e) {
      AppConstants.showSnack('Service Unavailable.');
      log(
        'Error: $e',
        name: 'Google Service (WEB)',
      );
      throw Exception(e);
    }
  }

  Future<MutationUsercreateUserIfNotExists?> createUser({
    required String userId,
    required String email,
    required String avatar,
    required String name,
  }) async {
    final result = await AppClient.client.mutateUser(
      OptionsMutationUser(
        variables: VariablesMutationUser(
          name: name,
          userId: userId,
          email: email,
          avatar: avatar,
        ),
      ),
    );

    if (!result.hasException) {
      return result.parsedData?.createUserIfNotExists;
    } else {
      return null;
    }
  }
}
