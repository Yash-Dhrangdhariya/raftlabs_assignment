import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:raftlabs_assignment/utils/shared_preferences_helper.dart';

import '../../../src/graphql/__generated__/get_all_users.data.gql.dart';
import '../../../values/app_colors.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.user,
    required this.onTapFollow,
    super.key,
  });

  final Observable<GGetAllUsersData_getUsersExcept?> user;
  final VoidCallback onTapFollow;

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
                  user.value?.avatar ?? '',
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
                      user.value?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      user.value?.email ?? '',
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
              Observer(
                builder: (context) {
                  final isFollowed = user.value?.followers.contains(
                        SharedPreferencesHelper().getLoginUser()!.userId,
                      ) ??
                      false;

                  return FilledButton(
                    onPressed: onTapFollow,
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
