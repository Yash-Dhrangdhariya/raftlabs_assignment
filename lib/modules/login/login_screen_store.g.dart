// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginScreenStore on _LoginScreenStore, Store {
  late final _$isSignInAtom =
      Atom(name: '_LoginScreenStore.isSignIn', context: context);

  @override
  bool get isSignIn {
    _$isSignInAtom.reportRead();
    return super.isSignIn;
  }

  @override
  set isSignIn(bool value) {
    _$isSignInAtom.reportWrite(value, super.isSignIn, () {
      super.isSignIn = value;
    });
  }

  @override
  String toString() {
    return '''
isSignIn: ${isSignIn}
    ''';
  }
}
