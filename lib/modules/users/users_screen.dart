import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:raftlabs_assignment/modules/users/widgets/user_tile.dart';
import 'package:raftlabs_assignment/services/graphql/graphql_service.dart';
import 'package:raftlabs_assignment/utils/data_helper.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = SharedPreferencesHelper.instance.getLoginUser()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Query(
        options: GraphQLService().queryGetUsersExcept(
          userId: currentUser.userId,
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
                return UserTile(
                  user: users[index],
                  isFollowed: isFollowed,
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
