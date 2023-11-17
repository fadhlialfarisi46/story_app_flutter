/*
 * *
 *  * Created by fadhlialfarisi on 11/8/23, 8:20 AM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/8/23, 8:20 AM
 *
 */

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:story_app_flutter/data/response/detail_story_response.dart';
import 'package:story_app_flutter/data/response/login_response.dart';
import 'package:story_app_flutter/data/response/story_response.dart';

import '../response/no_data_response.dart';

class ApiService {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (kDebugMode) {
      print('response: ${response.statusCode}');
      print('response: ${response.body}');
    }

    return LoginResponse.fromJson(json.decode(response.body));
  }

  Future<NoDataResponse> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (kDebugMode) {
      print('response: ${response.statusCode}');
      print('response: ${response.body}');
    }

    return NoDataResponse.fromMap(json.decode(response.body));
  }

  Future<StoryResponse> getStories(String token,
      {int page = 1, int location = 0}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/stories').replace(queryParameters: {
        'page': page.toString(),
        'location': location.toString(),
      }),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (kDebugMode) {
      print('response: ${response.statusCode}');
      print('response: ${response.body}');
    }

    if (response.statusCode == 200) {
      return StoryResponse.fromJson(json.decode(response.body));
    } else {
      final message =
          StoryResponse.fromJson(json.decode(response.body)).message;
      throw Exception(message);
    }
  }

  Future<DetailStoryResponse> getDetailStory(String token, String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/stories/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return DetailStoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail story');
    }
  }

  Future<NoDataResponse> addStory(
    String token,
    String description,
    File photo,
    Float lat,
    Float lon,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {
        'Content-Type': 'multipart/form-data',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode({
        'description': description,
        'File': photo,
        'lat': lat,
        'lon': lon,
      }),
    );
    if (kDebugMode) {
      print('response: $response');
    }
    if (response.statusCode == 200) {
      return NoDataResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add story');
    }
  }

  Future<NoDataResponse> uploadStory(
    String token,
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    final uri = Uri.parse("$_baseUrl/stories");
    var request = http.MultipartRequest('POST', uri);

    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      bytes,
      filename: fileName,
    );
    final Map<String, String> fields = {
      "description": description,
    };
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);
    if (statusCode == 201) {
      final NoDataResponse noDataResponse = NoDataResponse.fromJson(
        responseData,
      );
      return noDataResponse;
    } else {
      throw Exception("error upload story");
    }
  }
}
