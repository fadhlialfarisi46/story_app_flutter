// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoDataResponse _$NoDataResponseFromJson(Map<String, dynamic> json) =>
    NoDataResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$NoDataResponseToJson(NoDataResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
