/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:34 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:34 PM
 *
 */

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class AuthPreference {
  final String stateKey = "state";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    // await Future.delayed(const Duration(seconds: 2));
    return preferences.getBool(stateKey) ?? false;
  }

  Future<bool> login() async {
    final preferences = await SharedPreferences.getInstance();
    // await Future.delayed(const Duration(seconds: 2));
    return preferences.setBool(stateKey, true);
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(stateKey, false);
  }

  final String userKey = "user";

  Future<bool> saveUser(User user) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(userKey, user.toJsonFromPreference());
  }

  Future<bool> deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(userKey, "");
  }

  Future<User?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    final json = preferences.getString(userKey) ?? "";
    User? user;
    try {
      user = User.fromJsonToPreference(json);
    } catch (e) {
      user = null;
    }
    return user;
  }
}
