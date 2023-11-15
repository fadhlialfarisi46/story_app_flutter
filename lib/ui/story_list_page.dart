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
  final Function() onClickAdd;

  const StoryListPage({
    super.key,
    required this.onTapped,
    required this.onLogout,
    required this.onClickAdd,
  });

  @override
  State<StoryListPage> createState() => _StoryListPageState();
}

class _StoryListPageState extends State<StoryListPage> {
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
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var story = state.result.listStory[index];
                return _buildListStory(story: story);
              },
              itemCount: state.result.listStory.length,
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

  Widget _buildListStory({required Story story}) {
    return InkWell(
      onTap: () {
        widget.onTapped(story.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 250,
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
