import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../src/graphql/get_news.graphql.dart';
import '../home_screen_store.dart';
import 'news_tile.dart';

class NewsView extends StatelessWidget {
  NewsView({super.key});

  final _store = Modular.get<HomeScreenStore>();

  @override
  Widget build(BuildContext context) {
    return Query(
      builder: (result, {refetch, fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final news = result.parsedData?.getNews;

        if (news?.isEmpty ?? true) {
          return const Center(
            child: Text('No News'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: news!.length,
          itemBuilder: (context, index) {
            return NewsTile(
              news: news[index],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
            height: 30,
          ),
        );
      },
      options: OptionsQueryGetNews(
        variables: VariablesQueryGetNews(
          userId: _store.user?.userId ?? '',
        ),
      ),
    );
  }
}
