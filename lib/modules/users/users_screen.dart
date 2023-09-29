import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:raftlabs_assignment/services/graphql/graphql_service.dart';
import 'package:raftlabs_assignment/utils/data_helper.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';
import 'package:raftlabs_assignment/values/app_colors.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = SharedPreferencesHelper.instance.getLoginUser()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Query(
        options: GraphQLService().queryForGetExceptUser(
          currentUser.userId,
        ),
        builder: (result, {refetch, fetchMore}) {
          if (result.hasException) {
            return const Center(
              child: Text('Oops! Something Went Wrong!'),
            );
          }
          if (result.data != null) {
            final users = DataHelper().toListOfUsers(result.data!);
            if (users.isEmpty) {
              return const Center(
                child: Text('No Users'),
              );
            }
            return ListView.separated(
              itemCount: users.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final isFollowed =
                    users[index].followers.contains(currentUser.userId);
                return ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: ColoredBox(
                    color: AppColors.greyLightColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  users[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  users[index].email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Mutation(
                            options: GraphQLService().mutationForEditUser(
                              senderId: currentUser.userId,
                              receiverId: users[index].id,
                            ),
                            builder: (runMutation, result) {
                              return FilledButton(
                                onPressed: () {
                                  runMutation(
                                    {
                                      'sendingUserId': currentUser.userId,
                                      'receivingUserId': users[index].userId,
                                    },
                                  );
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor:
                                      isFollowed ? Colors.white : Colors.black,
                                  foregroundColor:
                                      isFollowed ? Colors.black : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Text(
                                  isFollowed ? 'Unfollow' : 'Follow',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 20,
              ),
            );
          }
          return const Center(
            child: Text('No Users'),
          );
        },
      ),
    );
  }
}
