/*
 * *
 *  * Created by fadhlialfarisi on 11/8/23, 8:56 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/8/23, 8:56 PM
 *
 */
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../model/story.dart';

part 'story_response.g.dart';

@JsonSerializable()
class StoryResponse {
  bool error;
  String message;
  List<Story> listStory;

  StoryResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResponseToJson(this);
}
