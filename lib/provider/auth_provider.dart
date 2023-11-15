/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:41 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:41 PM
 *
 */
import 'package:flutter/material.dart';
import 'package:story_app_flutter/data/preference/auth_preference.dart';

import '../data/api_service/api_service.dart';
import '../data/model/user.dart';

class AuthProvider extends ChangeNotifier {
  final AuthPreference authPreference;
  final ApiService apiService;

  AuthProvider(this.authPreference, this.apiService);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;

  Future<bool> login(String email, String password) async {
    isLoadingLogin = true;
    notifyListeners();

    final response = await apiService.login(email, password);
    if (response.error) {
      isLoadingLogin = false;
      notifyListeners();
      return false;
    }
    await authPreference.saveUser(response.loginResult!);
    await authPreference.login();
    isLoggedIn = await authPreference.isLoggedIn();

    isLoadingLogin = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<bool> register(String name, String email, String password) async {
    isLoadingRegister = true;
    notifyListeners();

    final response = await apiService.register(name, email, password);
    if (response.error) {
      isLoadingRegister = false;
      notifyListeners();
      return false;
    }

    isLoadingRegister = false;
    notifyListeners();
    return true;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    final logout = await authPreference.logout();
    if (logout) {
      await authPreference.deleteUser();
    }
    isLoggedIn = await authPreference.isLoggedIn();

    isLoadingLogout = false;
    notifyListeners();

    return !isLoggedIn;
  }

  Future<bool> saveUser(User user) async {
    isLoadingRegister = true;
    notifyListeners();

    final userState = await authPreference.saveUser(user);

    isLoadingRegister = false;
    notifyListeners();

    return userState;
  }
}
