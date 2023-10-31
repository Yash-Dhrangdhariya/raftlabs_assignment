import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/user_model.dart';
import '../../values/app_constants.dart';

class GoogleService {
  factory GoogleService() => instance;

  GoogleService._();

  static final instance = GoogleService._();

  Future<UserModel?> signInWithGoogle() async {
    /// start auth process
    final currentUser = await GoogleSignIn().signIn();

    /// Obtain the auth details from the request
    final googleAuth = await currentUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // final data = await UserService().setUser(
      final data = UserModel(
        userId: userCredential.user?.uid ?? '',
        name: userCredential.user?.displayName ?? '',
        email: userCredential.user?.email ?? '',
        avatar: userCredential.user?.photoURL ?? '',
        followers: [],
        followings: [],
        news: [],
        id: AppConstants.uuid.v4(),
      );
      // );
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

  Future<UserModel?> signInWithGoogleWeb() async {
    final authProvider = GoogleAuthProvider();
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithPopup(authProvider);
      final firebaseUser = userCredential.user;
      final user = UserModel(
        name: firebaseUser?.displayName ?? '',
        email: firebaseUser?.email ?? '',
        userId: firebaseUser?.uid ?? '',
        avatar: firebaseUser?.photoURL ?? '',
        followings: [],
        followers: [],
        news: [],
        id: AppConstants.uuid.v4(),
      );
      // final user = await UserService().setUser();
      return user;
    } catch (e) {
      AppConstants.showSnack('Service Unavailable.');
      log(
        'Error: $e',
        name: 'Google Service (WEB)',
      );
      throw Exception(e);
    }
  }
}
