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
import 'package:story_app_flutter/data/preference/auth_preference.dart';
import 'package:story_app_flutter/data/response/story_response.dart';

class StoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthPreference authPreference;

  StoryProvider({required this.apiService, required this.authPreference}) {
    fetchStories();
  }

  late StoryResponse _storyResponse;
  StoryResponse get result => _storyResponse;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchStories() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final user = await authPreference.getUser();
      final token = user?.token ?? "";
      final stories = await apiService.getStories(token);

      if (stories.listStory.isNotEmpty) {
        _state = ResultState.success;
        notifyListeners();
        return _storyResponse = stories;
      }

      _state = ResultState.error;
      notifyListeners();
      return _message = "Empty Data";
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'No internet connection. Make sure your Wi-Fi or mobile data is turned on, then try again.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
