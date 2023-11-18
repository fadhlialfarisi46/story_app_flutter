// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryResponseImpl _$$StoryResponseImplFromJson(Map<String, dynamic> json) =>
    _$StoryResponseImpl(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StoryResponseImplToJson(_$StoryResponseImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
