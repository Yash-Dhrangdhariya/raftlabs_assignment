import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:raftlabs_assignment/values/app_colors.dart';
import 'package:raftlabs_assignment/values/app_constants.dart';
import 'package:raftlabs_assignment/values/app_text_style.dart';

import 'post_news_screen_store.dart';
import 'widgets/blurred_button.dart';

class PostNewsScreen extends StatelessWidget {
  PostNewsScreen({super.key});

  final _store = Modular.get<PostNewsScreenStore>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_store.isLoading;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post News'),
          actions: [
            Observer(
              builder: (context) {
                if (_store.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(
                      right: 20,
                    ),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ),
                  );
                }
                return TextButton(
                  onPressed: _store.isLoading || _store.selectedImage == null
                      ? null
                      : () async {
                          if (_store.title != null &&
                              _store.description != null) {
                            await _store.sendPost();
                          } else {
                            AppConstants.showSnack("Fields Can't be empty!");
                          }
                        },
                  child: const Text(
                    'Share',
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ColoredBox(
                color: Colors.grey.shade200,
                child: Observer(
                  builder: (context) {
                    if (_store.selectedImage != null) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ColoredBox(
                            color: Colors.white,
                            child: Image.file(
                              _store.selectedImage!,
                            ),
                          ),
                          Positioned(
                            right: 14,
                            bottom: 14,
                            child: Observer(
                              builder: (context) {
                                if (_store.isLoading) {
                                  return const SizedBox();
                                }
                                return BlurredButton(
                                  text: 'Re-Select Image',
                                  onTap: () async => _store.pickImage(),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: Observer(
                        builder: (context) {
                          return TextButton(
                            onPressed: _store.isLoading
                                ? null
                                : () async => _store.pickImage(),
                            child: const Text('Select Image'),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (context) {
                    return TextFormField(
                      minLines: 1,
                      readOnly: _store.isLoading,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: _store.onChangeTitle,
                      onTapOutside: (value) => FocusScope.of(context).unfocus(),
                      style: AppTextStyles.headline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.greyLightColor,
                        hintText: 'Write about a Headline...',
                        hintStyle: AppTextStyles.headline.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (context) {
                    return TextField(
                      minLines: 3,
                      maxLines: 6,
                      readOnly: _store.isLoading,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: _store.onChangeDesc,
                      onTapOutside: (value) => FocusScope.of(context).unfocus(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.greyLightColor,
                        hintText: 'Write about a News Description...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
