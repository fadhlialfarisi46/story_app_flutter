/*
 * *
 *  * Created by fadhlialfarisi on 11/10/23, 8:25 AM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/10/23, 8:25 AM
 *
 */
import 'package:freezed_annotation/freezed_annotation.dart';

part 'no_data_response.g.dart';
part 'no_data_response.freezed.dart';

@freezed
class NoDataResponse with _$NoDataResponse {
  // bool error;
  // String message;

  const factory NoDataResponse({
    required bool error,
    required String message,
  }) = _NoDataResponse;

  factory NoDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NoDataResponseFromJson(json);

  // Map<String, dynamic> toJson() => _$NoDataResponseToJson(this);
}
