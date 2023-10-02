import 'dart:async';
import 'dart:developer';

import 'package:ferry/ferry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:raftlabs_assignment/values/app_constants.dart';

import '../../src/graphql/__generated__/create_user.data.gql.dart';
import '../../src/graphql/__generated__/create_user.req.gql.dart';

class GoogleService {
  factory GoogleService() => instance;

  GoogleService._();

  static final instance = GoogleService._();

  Future<GCreateUserData_createUserIfNotExists?> signInWithGoogle() async {
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

  Future<GCreateUserData_createUserIfNotExists?> signInWithGoogleWeb() async {
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

  Future<GCreateUserData_createUserIfNotExists?> createUser({
    required String userId,
    required String email,
    required String avatar,
    required String name,
  }) async {
    final completer = Completer<GCreateUserData_createUserIfNotExists>();

    Modular.get<TypedLink>()
        .request(
      GCreateUserReq(
        (b) => b.vars
          ..userId = userId
          ..email = email
          ..avatar = avatar
          ..name = name,
      ),
    )
        .listen(
      (event) {
        if (!event.loading) {
          completer.complete(
            event.data?.createUserIfNotExists,
          );
        } else {
          if (event.hasErrors) {
            completer.completeError(event.linkException!.originalException!);
          }
        }
      },
    );
    return completer.future;
  }
}
