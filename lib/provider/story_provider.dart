/*
 * *
 *  * Created by fadhlialfarisi on 11/8/23, 8:52 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/8/23, 8:52 PM
 *
 */
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:story_app_flutter/common/state_management.dart';
import 'package:story_app_flutter/data/api_service/api_service.dart';
import 'package:story_app_flutter/data/model/story.dart';
import 'package:story_app_flutter/data/preference/auth_preference.dart';
import 'package:story_app_flutter/data/response/story_response.dart';

class StoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthPreference authPreference;

  StoryProvider({required this.apiService, required this.authPreference}) {
    fetchStories();
  }

  int? page = 1;
  List<Story> stories = [];

  late StoryResponse _storyResponse;
  StoryResponse get result => _storyResponse;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchStories() async {
    try {
      if (page == 1) {
        _state = ResultState.loading;
        notifyListeners();
      }

      final user = await authPreference.getUser();
      final token = user?.token ?? "";
      final response = await apiService.getStories(token, page: page ?? 1);

      if (response.listStory.isNotEmpty) {
        if (response.listStory.length < 10) {
          // 10 is default pageSize
          page = null;
        } else {
          page = page! + 1;
        }
        stories += response.listStory;
        _state = ResultState.success;
        page = page! + 1;
        _storyResponse = response;
        notifyListeners();
      } else {
        if (page == 1) {
          _state = ResultState.error;
          _message = "Empty Data";
          notifyListeners();
        }
      }
    } on SocketException {
      _state = ResultState.error;
      _message =
          'No internet connection. Make sure your Wi-Fi or mobile data is turned on, then try again.';
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}
