
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:raftlabs_assignment/modules/home/home_screen_store.dart';
import 'package:raftlabs_assignment/modules/home/widgets/news_tile.dart';
import 'package:raftlabs_assignment/services/graphql/graphql_service.dart';
import 'package:raftlabs_assignment/utils/data_helper.dart';

class NewsView extends StatelessWidget {
  NewsView({super.key});

  final _store = Modular.get<HomeScreenStore>();

  @override
  Widget build(BuildContext context) {
    return Query(
      options: GraphQLService().queryGetNews(
        _store.currentUser!.userId,
      ),
      builder: (result, {refetch, fetchMore}) {
        if (result.hasException) {
          return const Text('Oops! Something Went Wrong');
        }
        if (result.data != null) {
          final news = DataHelper().toListOfNews(result.data!);
          if (news.isNotEmpty) {
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: news.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return NewsTile(
                  news: news[index],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 30,
              ),
            );
          }
          return const Center(
            child: Text('No News'),
          );
        }
        return const Center(
          child: Text('No News'),
        );
      },
    );
  }
}
