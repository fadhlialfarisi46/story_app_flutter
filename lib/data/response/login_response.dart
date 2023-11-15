/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:47 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:47 PM
 *
 */

import 'dart:convert';

import 'package:story_app_flutter/data/model/user.dart';

class LoginResponse {
  bool error;
  String message;
  User? loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    this.loginResult,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        error: json["error"],
        message: json["message"],
        loginResult: json["loginResult"] == null
            ? null
            : User.fromJson(json["loginResult"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "loginResult": loginResult?.toJson(),
      };
}
