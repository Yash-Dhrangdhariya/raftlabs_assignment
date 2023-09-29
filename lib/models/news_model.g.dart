// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NewsModel _$$_NewsModelFromJson(Map<String, dynamic> json) => _$_NewsModel(
      id: json['_id'] as String,
      author: json['author'] as String,
      authorId: json['authorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      publishedAt: json['publishedAt'] as String?,
    );

Map<String, dynamic> _$$_NewsModelToJson(_$_NewsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'authorId': instance.authorId,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'publishedAt': instance.publishedAt,
    };
