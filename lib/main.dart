import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'app_modules.dart';
import 'firebase_options.dart';
import 'social_media_app.dart';
import 'utils/shared_preferences_helper.dart';
import 'values/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesHelper.initialize();
  await initHiveForFlutter();
  runApp(
    GraphQLProvider(
      client: ValueNotifier<GraphQLClient>(
        AppConstants.graphqlClient,
      ),
      child: ModularApp(
        module: AppModules(),
        child: const SocialMediaApp(),
      ),
    ),
  );
}
