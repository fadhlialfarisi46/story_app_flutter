/*
 * *
 *  * Created by fadhlialfarisi on 11/8/23, 8:56 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/8/23, 8:56 PM
 *
 */
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/story.dart';

part 'story_response.g.dart';
part 'story_response.freezed.dart';

@freezed
class StoryResponse with _$StoryResponse {
  // bool error;
  // String message;
  // List<Story> listStory;

  const factory StoryResponse({
    required bool error,
    required String message,
    required List<Story> listStory,
  }) = _StoryResponse;

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);

  // Map<String, dynamic> toJson() => _$StoryResponseToJson(this);
}
