import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@unfreezed
class UserModel with _$UserModel {
  factory UserModel({
    @JsonKey(
      name: '_id',
    )
    required String id,
    required String name,
    required String userId,
    required String email,
    required String avatar,
    required List<String> news,
    required List<String> followings,
    required List<String> followers,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
