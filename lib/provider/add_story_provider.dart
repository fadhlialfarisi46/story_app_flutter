/*
 * *
 *  * Created by fadhlialfarisi on 11/10/23, 8:28 AM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/10/23, 8:28 AM
 *
 */

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:story_app_flutter/data/response/no_data_response.dart';

import '../data/api_service/api_service.dart';
import '../data/preference/auth_preference.dart';

class AddStoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthPreference authPreference;

  AddStoryProvider({
    required this.apiService,
    required this.authPreference,
  });

  String? imagePath;

  XFile? imageFile;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    Uint8List bytesUint = Uint8List.fromList(bytes);

    final img.Image image = img.decodeImage(bytesUint)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      ///
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }

  Future<List<int>> resizeImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    Uint8List bytesUint = Uint8List.fromList(bytes);

    final img.Image image = img.decodeImage(bytesUint)!;
    bool isWidthMoreTaller = image.width > image.height;
    int imageTall = isWidthMoreTaller ? image.width : image.height;
    double compressTall = 1;
    int length = imageLength;
    List<int> newByte = bytes;

    do {
      ///
      compressTall -= 0.1;

      final newImage = img.copyResize(
        image,
        width: isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
        height: !isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
      );

      length = newImage.length;
      if (length < 1000000) {
        newByte = img.encodeJpg(newImage);
      }
    } while (length > 1000000);

    return newByte;
  }

  bool isUploading = false;
  String message = "";
  NoDataResponse? noDataResponse;

  Future<void> setUploadLoading() async {
    isUploading = true;
  }

  Future<void> upload(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    try {
      message = "";
      noDataResponse = null;
      isUploading = true;
      notifyListeners();

      final user = await authPreference.getUser();
      final token = user?.token ?? "";
      noDataResponse =
          await apiService.uploadStory(token, bytes, fileName, description);
      message = noDataResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }
}
