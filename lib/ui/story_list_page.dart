/*
 * *
 *  * Created by fadhlialfarisi on 11/8/23, 8:05 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/8/23, 8:05 PM
 *
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_flutter/common/state_management.dart';
import 'package:story_app_flutter/data/model/story.dart';
import 'package:story_app_flutter/provider/story_provider.dart';

import '../provider/auth_provider.dart';

class StoryListPage extends StatefulWidget {
  final Function(String) onTapped;
  final Function() onLogout;
  final Function() onMaps;
  final Function() onClickAdd;

  const StoryListPage({
    super.key,
    required this.onTapped,
    required this.onLogout,
    required this.onClickAdd,
    required this.onMaps,
  });

  @override
  State<StoryListPage> createState() => _StoryListPageState();
}

class _StoryListPageState extends State<StoryListPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final storyProvider = context.read<StoryProvider>();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (storyProvider.page != null) {
          storyProvider.fetchStories();
        }
      }
    });

    Future.microtask(() async => await storyProvider.fetchStories());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stories For you',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.place_outlined,
              color: Colors.blue,
            ),
            tooltip: 'Maps',
            onPressed: () async {
              widget.onMaps();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            tooltip: 'Logout',
            onPressed: () async {
              final authRead = context.read<AuthProvider>();
              final result = await authRead.logout();
              if (result) widget.onLogout();
            },
          ),
        ],
      ),
      body: Consumer<StoryProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.state == ResultState.success) {
            return ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == state.stories.length && state.page != null) {
                  return _buildLoadingFooter();
                }

                var story = state.stories[index];
                return _buildListStory(story: story);
              },
              itemCount: state.stories.length + (state.page != null ? 1 : 0),
            );
          }

          return Center(
            child: Text(state.message),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onClickAdd();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Center _buildLoadingFooter() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildListStory({required Story story}) {
    return InkWell(
      onTap: () {
        widget.onTapped(story.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 260,
          child: Card(
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Hero(
                            tag: story.photoUrl,
                            child: Image.network(
                              story.photoUrl,
                              fit: BoxFit.fill,
                            )),
                      )),
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              story.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              story.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              story.createdAt.toString(),
                              textAlign: TextAlign.end,
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
