/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:47 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:47 PM
 *
 */

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  // String userId;
  // String name;
  // String token;

  const factory User({
    required String userId,
    required String name,
    required String token,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // Map<String, dynamic> toJson() => _$UserToJson(this);

  String toJsonFromPreference() => json.encode(toJson());

  factory User.fromJsonToPreference(String source) =>
      User.fromJson(json.decode(source));
}
