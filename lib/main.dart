import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_modules.dart';
import 'firebase_options.dart';
import 'social_media_news_app.dart';
import 'utils/shared_preferences_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesHelper.initialize();
  runApp(
    ModularApp(
      module: AppModules(),
      child: const SocialMediaNewsApp(),
    ),
  );
}
