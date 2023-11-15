/*
 * *
 *  * Created by fadhlialfarisi on 11/10/23, 8:25 AM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/10/23, 8:25 AM
 *
 */

import 'dart:convert';

class NoDataResponse {
  bool error;
  String message;

  NoDataResponse({
    required this.error,
    required this.message,
  });

  factory NoDataResponse.fromMap(Map<String, dynamic> map) {
    return NoDataResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }

  factory NoDataResponse.fromJson(String source) =>
      NoDataResponse.fromMap(json.decode(source));

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
