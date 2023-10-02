import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:raftlabs_assignment/src/graphql/__generated__/get_news.data.gql.dart';
import 'package:raftlabs_assignment/utils/extension.dart';
import 'package:raftlabs_assignment/values/app_colors.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    required this.news,
    super.key,
  });

  final GGetNewsData_getNews? news;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.greyLightColor,
          image: DecorationImage(
            image: NetworkImage(
              news?.image ?? '-',
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 40,
              spreadRadius: -30,
            ),
          ],
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black26,
                Colors.black54,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: ColoredBox(
                        color: Colors.white38,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          child: Text(
                            news?.publishedAt.value.toPublishedDate() ?? '-',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Text(
                    news?.title ?? '-',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
