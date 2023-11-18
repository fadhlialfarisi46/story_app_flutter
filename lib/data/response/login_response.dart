/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:47 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:47 PM
 *
 */

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:story_app_flutter/data/model/user.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  bool error;
  String message;
  User? loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    this.loginResult,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
