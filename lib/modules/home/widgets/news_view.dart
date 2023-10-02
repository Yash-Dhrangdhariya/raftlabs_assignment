import 'package:built_collection/built_collection.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../src/graphql/__generated__/get_news.data.gql.dart';
import '../../../src/graphql/__generated__/get_news.req.gql.dart';
import '../../../src/graphql/__generated__/get_news.var.gql.dart';
import '../home_screen_store.dart';
import 'news_tile.dart';

class NewsView extends StatelessWidget {
  NewsView({super.key});

  final _store = Modular.get<HomeScreenStore>();
  final _client = Modular.get<TypedLink>();

  @override
  Widget build(BuildContext context) {
    return Operation<GGetNewsData, GGetNewsVars>(
      client: _client,
      operationRequest: GGetNewsReq(
        (a) => a..vars.userId = _store.user?.userId ?? '',
      ),
      builder: (context, response, error) {
        if (response!.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final news = response.data?.getNews ?? BuiltList();

        return RefreshIndicator(
          onRefresh: () async => _client.request(
            GGetNewsReq(
              (a) => a..vars.userId = _store.user?.userId ?? '',
            ),
          ),
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: news.length,
            itemBuilder: (context, index) {
              return NewsTile(
                news: news[index],
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
