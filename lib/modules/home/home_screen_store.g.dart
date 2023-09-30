// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeScreenStore on _HomeScreenStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_HomeScreenStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isNewsLoadingAtom =
      Atom(name: '_HomeScreenStore.isNewsLoading', context: context);

  @override
  bool get isNewsLoading {
    _$isNewsLoadingAtom.reportRead();
    return super.isNewsLoading;
  }

  @override
  set isNewsLoading(bool value) {
    _$isNewsLoadingAtom.reportWrite(value, super.isNewsLoading, () {
      super.isNewsLoading = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_HomeScreenStore.currentUser', context: context);

  @override
  UserModel? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserModel? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$newsAtom = Atom(name: '_HomeScreenStore.news', context: context);

  @override
  ObservableList<NewsModel> get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(ObservableList<NewsModel> value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isNewsLoading: ${isNewsLoading},
currentUser: ${currentUser},
news: ${news}
    ''';
  }
}
