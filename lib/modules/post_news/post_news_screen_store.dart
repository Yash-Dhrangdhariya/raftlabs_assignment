import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../../src/graphql/create_news.graphql.dart';
import '../../values/app_client.dart';
import '../../values/app_constants.dart';
import '../home/home_screen_store.dart';

part 'post_news_screen_store.g.dart';

class PostNewsScreenStore = _PostNewsScreenStore with _$PostNewsScreenStore;

abstract class _PostNewsScreenStore with Store {
  @observable
  bool isLoading = false;

  @observable
  File? selectedImage;

  @observable
  String? title;

  @observable
  String? description;

  // ignore: use_setters_to_change_properties
  void onChangeTitle(String value) => title = value;

  // ignore: use_setters_to_change_properties
  void onChangeDesc(String value) => description = value;

  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      }
    } catch (e) {
      AppConstants.showSnack('Unable To Pick Image');
      throw Exception(e);
    }
  }

  Future<void> sendPost() async {
    isLoading = true;
    final user = Modular.get<HomeScreenStore>().user;
    try {
      final compressImage = await FlutterImageCompress.compressWithFile(
        selectedImage!.path,
        quality: 70,
        minWidth: 720,
        minHeight: 720,
      );
      log(
        'Image Size: ${compressImage!.length / 1024}',
        name: 'Compress Image',
      );

      final data = await FirebaseStorage.instance
          .ref()
          .child(
            'news/${user?.name ?? ''}/${DateTime.timestamp().toIso8601String()}',
          )
          .putData(compressImage);

      final firebaseImage = await data.ref.getDownloadURL();

      await AppClient.client.mutateOnNews(
        OptionsMutationOnNews(
          variables: VariablesMutationOnNews(
            author: user?.name ?? 'Unknown',
            authorId: user?.userId ?? 'Unknown',
            title: title ?? '-',
            description: description ?? '-',
            image: firebaseImage,
          ),
        ),
      );
    } catch (e) {
      log(
        'Error: $e',
        name: 'Upload Story',
      );
      AppConstants.showSnack(
        "Couldn't Upload! Please, Try Again",
      );
    } finally {
      isLoading = false;
      Modular.to.pop();
    }
  }
}
