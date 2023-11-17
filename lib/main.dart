import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_flutter/common/route_delegate.dart';
import 'package:story_app_flutter/data/api_service/api_service.dart';
import 'package:story_app_flutter/data/preference/auth_preference.dart';
import 'package:story_app_flutter/provider/add_story_provider.dart';
import 'package:story_app_flutter/provider/auth_provider.dart';
import 'package:story_app_flutter/provider/maps_provider.dart';
import 'package:story_app_flutter/provider/story_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;
  late AddStoryProvider addStoryProvider;
  late StoryProvider storyProvider;
  late MapsProvider mapsProvider;

  @override
  void initState() {
    super.initState();

    final authPreference = AuthPreference();
    final apiService = ApiService();

    authProvider = AuthProvider(authPreference, apiService);
    storyProvider =
        StoryProvider(apiService: apiService, authPreference: authPreference);
    mapsProvider =
        MapsProvider(apiService: apiService, authPreference: authPreference);
    addStoryProvider = AddStoryProvider(
        apiService: apiService, authPreference: authPreference);
    myRouterDelegate = MyRouterDelegate(authPreference);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => storyProvider),
        ChangeNotifierProvider(create: (context) => mapsProvider),
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(create: (context) => addStoryProvider),
      ],
      child: MaterialApp(
        title: 'Story App',
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
