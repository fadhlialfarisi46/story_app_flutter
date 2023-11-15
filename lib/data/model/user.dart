/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:47 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:47 PM
 *
 */

import 'dart:convert';

class User {
  String userId;
  String name;
  String token;

  User({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "token": token,
      };

  String toJsonFromPreference() => json.encode(toJson());

  factory User.fromJsonToPreference(String source) =>
      User.fromJson(json.decode(source));
}
