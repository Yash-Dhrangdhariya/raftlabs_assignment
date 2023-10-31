import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home_screen_store.dart';
import 'news_tile.dart';

class NewsView extends StatelessWidget {
  NewsView({super.key});

  final _store = Modular.get<HomeScreenStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_store.isNewsLoading) {
          return const Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (_store.news.isEmpty) {
          return const Center(
            child: Text('No News'),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => _store.getNews(),
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: _store.news.length,
            itemBuilder: (context, index) {
              return NewsTile(
                news: _store.news[index],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 30,
            ),
          ),
        );
      },
    );
  }
}
