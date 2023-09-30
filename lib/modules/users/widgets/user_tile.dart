import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:raftlabs_assignment/models/user_model.dart';
import 'package:raftlabs_assignment/modules/home/home_screen_store.dart';
import 'package:raftlabs_assignment/services/graphql/graphql_service.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';
import 'package:raftlabs_assignment/values/app_colors.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.user,
    required this.isFollowed,
    super.key,
  });

  final UserModel user;
  final bool isFollowed;

  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  user.avatar,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      user.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Mutation(
                options: GraphQLService().mutationForEditUser(),
                builder: (runMutation, result) {
                  return FilledButton(
                    onPressed: () {
                      runMutation(
                        {
                          'sendingUserId': SharedPreferencesHelper.instance
                              .getLoginUser()!
                              .userId,
                          'receivingUserId': user.userId,
                        },
                      );
                      Modular.get<HomeScreenStore>().getNews();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: isFollowed ? Colors.white : Colors.black,
                      foregroundColor: isFollowed ? Colors.black : Colors.white,
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
  }
}
