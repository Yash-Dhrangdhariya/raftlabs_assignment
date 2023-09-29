// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      news: (json['news'] as List<dynamic>).map((e) => e as String).toList(),
      followings: (json['followings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      followers:
          (json['followers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'email': instance.email,
      'avatar': instance.avatar,
      'news': instance.news,
      'followings': instance.followings,
      'followers': instance.followers,
    };
