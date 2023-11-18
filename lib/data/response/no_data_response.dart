/*
 * *
 *  * Created by fadhlialfarisi on 11/10/23, 8:25 AM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/10/23, 8:25 AM
 *
 */

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'no_data_response.g.dart';

@JsonSerializable()
class NoDataResponse {
  bool error;
  String message;

  NoDataResponse({
    required this.error,
    required this.message,
  });

  factory NoDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NoDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NoDataResponseToJson(this);
}
