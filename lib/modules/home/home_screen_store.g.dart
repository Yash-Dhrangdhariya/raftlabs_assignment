// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeScreenStore on _HomeScreenStore, Store {
  late final _$userAtom = Atom(name: '_HomeScreenStore.user', context: context);

  @override
  GGetUserData_userById? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(GGetUserData_userById? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
