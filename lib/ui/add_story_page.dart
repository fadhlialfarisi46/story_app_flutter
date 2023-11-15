/*
 * *
 *  * Created by fadhlialfarisi on 11/9/23, 10:38 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/9/23, 10:38 PM
 *
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app_flutter/provider/add_story_provider.dart';
import 'package:story_app_flutter/provider/story_provider.dart';

class AddStoryPage extends StatefulWidget {
  final Function onBack;

  const AddStoryPage({super.key, required this.onBack});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Story"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onBack();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            context.watch<AddStoryProvider>().imagePath == null
                ? _buildPlaceholderImage(context)
                : _showImage(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Select image from:",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () => _onCameraView(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: const Text("Camera"),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () => _onGalleryView(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: const Text("Gallery"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: descriptionController,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Add description';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Description",
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        context.read<AddStoryProvider>().isUploading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () {
                                  final scaffoldMessenger =
                                      ScaffoldMessenger.of(context);

                                  if (!formKey.currentState!.validate()) {
                                    scaffoldMessenger.showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Your description is invalid"),
                                      ),
                                    );
                                    return;
                                  }
                                  if (context
                                          .read<AddStoryProvider>()
                                          .imagePath ==
                                      null) {
                                    scaffoldMessenger.showSnackBar(
                                      const SnackBar(
                                        content: Text("Your image is invalid"),
                                      ),
                                    );
                                    return;
                                  }

                                  _onUpload();
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(48),
                                    backgroundColor: Colors.green),
                                child: const Text("Submit your story"),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildPlaceholderImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      color: Colors.grey,
      child: const Icon(
        Icons.image,
        size: 100,
      ),
    );
  }

  _onUpload() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final addStoryProvider = context.read<AddStoryProvider>();
    await addStoryProvider.setUploadLoading();

    final storyProvider = context.read<StoryProvider>();

    final imagePath = addStoryProvider.imagePath;
    final imageFile = addStoryProvider.imageFile;
    if (imagePath == null || imageFile == null) return;

    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final newBytes = await addStoryProvider.compressImage(bytes);

    await addStoryProvider.upload(
      newBytes,
      // bytes,
      fileName,
      descriptionController.text,
    );

    if (addStoryProvider.noDataResponse != null) {
      addStoryProvider.setImageFile(null);
      addStoryProvider.setImagePath(null);
    }

    widget.onBack();
    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(addStoryProvider.message)),
    );

    if (addStoryProvider.noDataResponse?.error == false) {
      storyProvider.fetchStories();
    }
  }

  _onGalleryView() async {
    final provider = context.read<AddStoryProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    if (!isAndroid) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<AddStoryProvider>();

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    if (!isAndroid) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<AddStoryProvider>().imagePath;
    return Image.file(
      File(imagePath.toString()),
      fit: BoxFit.contain,
    );
  }
}
