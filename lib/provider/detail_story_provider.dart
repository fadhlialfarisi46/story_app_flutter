/*
 * *
 *  * Created by fadhlialfarisi on 11/9/23, 8:26 AM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/9/23, 8:26 AM
 *
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../common/state_management.dart';
import '../data/api_service/api_service.dart';
import '../data/preference/auth_preference.dart';
import '../data/response/detail_story_response.dart';

class DetailStoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  final AuthPreference authPreference;

  DetailStoryProvider(
      {required this.apiService,
      required this.authPreference,
      required this.id}) {
    _fetchDetailStory(id);
  }

  late DetailStoryResponse _storyResult;
  DetailStoryResponse get result => _storyResult;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> _fetchDetailStory(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final user = await authPreference.getUser();
      final token = user?.token ?? "";
      final story = await apiService.getDetailStory(token, id);
      if (story.error) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Failed to load data';
      }

      _state = ResultState.success;
      notifyListeners();
      return _storyResult = story;
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
