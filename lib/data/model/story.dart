/*
 * *
 *  * Created by fadhlialfarisi on 11/8/23, 8:57 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/8/23, 8:57 PM
 *
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.g.dart';
part 'story.freezed.dart';

@freezed
class Story with _$Story {
  // String id;
  // String name;
  // String description;
  // String photoUrl;
  // DateTime createdAt;
  // double? lat;
  // double? lon;

  const factory Story({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    required double? lat,
    required double? lon,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  // Map<String, dynamic> toJson() => _$StoryToJson(this);
}
