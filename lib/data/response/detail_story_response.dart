/*
 * *
 *  * Created by fadhlialfarisi on 11/9/23, 8:29 AM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/9/23, 8:29 AM
 *
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/story.dart';

part 'detail_story_response.g.dart';
part 'detail_story_response.freezed.dart';

@freezed
class DetailStoryResponse with _$DetailStoryResponse {
  // bool error;
  // String message;
  // Story story;

  const factory DetailStoryResponse({
    required bool error,
    required String message,
    required Story story,
  }) = _DetailStoryResponse;

  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryResponseFromJson(json);

  // Map<String, dynamic> toJson() => _$DetailStoryResponseToJson(this);
}
