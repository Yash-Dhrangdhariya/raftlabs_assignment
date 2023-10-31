import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../values/app_text_style.dart';
import '../home_screen_store.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar({super.key});

  final _store = Modular.get<HomeScreenStore>();

  static final appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'News',
        style: AppTextStyles.mediumBold,
      ),
      actions: [
        IconButton(
          onPressed: () async => _store.signOut(),
          icon: const Icon(Icons.login_rounded),
        ),
        const SizedBox(
          width: 10,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(
            _store.currentUser?.avatar ?? '',
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}
