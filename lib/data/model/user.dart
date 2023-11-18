/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:47 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:47 PM
 *
 */

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String userId;
  String name;
  String token;

  User({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String toJsonFromPreference() => json.encode(toJson());

  factory User.fromJsonToPreference(String source) =>
      User.fromJson(json.decode(source));
}
