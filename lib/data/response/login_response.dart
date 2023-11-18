/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:47 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:47 PM
 *
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app_flutter/data/model/user.dart';

part 'login_response.g.dart';
part 'login_response.freezed.dart';

@freezed
class LoginResponse with _$LoginResponse {
  // bool error;
  // String message;
  // User? loginResult;

  const factory LoginResponse({
    required bool error,
    required String message,
    User? loginResult,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  // Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
