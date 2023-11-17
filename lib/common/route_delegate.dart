/*
 * *
 *  * Created by fadhlialfarisi on 11/7/23, 9:39 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/7/23, 9:39 PM
 *
 */

import 'package:flutter/material.dart';
import 'package:story_app_flutter/data/preference/auth_preference.dart';
import 'package:story_app_flutter/ui/add_story_page.dart';
import 'package:story_app_flutter/ui/detail_story_page.dart';
import 'package:story_app_flutter/ui/login_page.dart';
import 'package:story_app_flutter/ui/maps_page.dart';
import 'package:story_app_flutter/ui/register_page.dart';
import 'package:story_app_flutter/ui/story_list_page.dart';

import '../ui/splash_screen_page.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthPreference authPreference;

  MyRouterDelegate(
    this.authPreference,
  ) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authPreference.isLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  String? selectedStory;

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool isOpenAddPage = false;
  bool isOpenMapsPage = false;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        selectedStory = null;
        isOpenAddPage = false;
        isOpenMapsPage = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashScreen"),
          child: SplashScreenPage(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginPage(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterPage(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("StoryListPage"),
          child: StoryListPage(
            onTapped: (String storyId) {
              selectedStory = storyId;
              notifyListeners();
            },
            onClickAdd: () {
              isOpenAddPage = true;
              notifyListeners();
            },
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
            onMaps: () {
              isOpenMapsPage = true;
              notifyListeners();
            },
          ),
        ),
        if (selectedStory != null)
          MaterialPage(
            key: ValueKey(selectedStory),
            child: DetailStoryPage(
                id: selectedStory!,
                onBack: () {
                  selectedStory = null;
                  notifyListeners();
                }),
          ),
        if (isOpenAddPage)
          MaterialPage(
            key: const ValueKey("AddStoryPage"),
            child: AddStoryPage(onBack: () {
              isOpenAddPage = false;
              notifyListeners();
            }),
          ),
        if (isOpenMapsPage)
          MaterialPage(
            key: const ValueKey("MapsPage"),
            child: MapsPage(onBack: () {
              isOpenMapsPage = false;
              notifyListeners();
            }),
          ),
      ];
}
