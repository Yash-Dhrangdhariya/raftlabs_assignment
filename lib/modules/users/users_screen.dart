import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'users_screen_store.dart';
import 'widgets/user_tile.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  final _store = Modular.get<UsersScreenStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Observer(
        builder: (context) {
          if (_store.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_store.users.isEmpty) {
            return const Center(
              child: Text('No Users'),
            );
          }
          return ListView.separated(
            itemCount: _store.users.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return UserTile(
                user: _store.users[index],
                onTapFollow: () async {
                  await _store.onTapFollow(
                    receiverUserId: _store.users[index].value?.userId ?? '',
                  );
                },
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 20,
            ),
          );
        },
      ),
    );
  }
}
