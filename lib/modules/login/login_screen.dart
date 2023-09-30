import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:raftlabs_assignment/modules/login/login_screen_store.dart';
import 'package:raftlabs_assignment/resources/images.dart';
import 'package:raftlabs_assignment/services/graphql/graphql_service.dart';
import 'package:raftlabs_assignment/values/app_routes.dart';
import 'package:raftlabs_assignment/values/app_text_style.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _store = Modular.get<LoginScreenStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              Images.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Connect 🤝',
                      style: AppTextStyles.mediumBold,
                    ),
                    Text(
                      'Share 📸',
                      style: AppTextStyles.mediumBold,
                    ),
                    Text(
                      'Thrive 💪',
                      style: AppTextStyles.mediumBold,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 6,
                        bottom: 12,
                      ),
                      child: Divider(
                        color: Colors.white10,
                      ),
                    ),
                    Text(
                      'Together, We Create the Story of Us.',
                      style: AppTextStyles.small,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Mutation(
                    options: GraphQLService().mutationForCreateUser(),
                    builder: (runMutation, result) => Observer(
                      builder: (context) {
                        return FilledButton(
                          onPressed: _store.isSignIn
                              ? null
                              : () async {
                                  final user = await _store.signIn();
                                  if (user != null) {
                                    runMutation(
                                      {
                                        'name': user.name,
                                        'userId': user.userId,
                                        'email': user.email,
                                        'avatar': user.avatar,
                                      },
                                    );
                                    Modular.to.navigate(AppRoutes.splashScreen);
                                  }
                                },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(
                              double.infinity,
                              52,
                            ),
                          ),
                          child: _store.isSignIn
                              ? const RepaintBoundary(
                                  child: SizedBox(
                                    height: 26,
                                    width: 26,
                                    child: CircularProgressIndicator(
                                      color: Colors.white30,
                                    ),
                                  ),
                                )
                              : const Text('Sign In'),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
