import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatImageService {
  Future<CroppedFile?> cropper(XFile? image) async {
    final croppedImage = await ImageCropper().cropImage(
        aspectRatio: const CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        cropStyle: CropStyle.rectangle,
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 20,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarWidgetColor: Colors.white,
              toolbarColor: Colors.black,
              statusBarColor: Colors.black,
              activeControlsWidgetColor: const Color(0xff7F87FF),
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ]);
    return croppedImage;
  }

  Future<bool> _askCameraPermission() async {
    final req = await Permission.camera.request();
    if (req.isGranted) {
      return true;
    }
    if (req.isPermanentlyDenied) {
      throw AppCameraModuleExpection(
          message: 'Permission permanently denied. Enable it from settings.');
    } else {
      return false;
    }
  }

  Future<List?> captureFromCamera({bool crop = false}) async {
    ImagePicker _imgPicker = ImagePicker();
    final bool isPermissionGranted = await _askCameraPermission();
    if (!isPermissionGranted) {
      return null;
    }

    final image = await _imgPicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (crop) {
        final cropped = await cropper(image);
        if (cropped != null) {
          return [
            File(cropped.path),
            image.name,
            image.path,
            File(cropped.path).lengthSync()
          ];
        } else {
          return null;
        }
      } else {
        return [
          File(image.path),
          image.name,
          image.path,
          File(image.path).lengthSync()
        ];
      }
    } else {
      return null;
    }
  }

  Future<List?> pickFromGallery({bool crop = false}) async {
    ImagePicker _imgPicker = ImagePicker();
    final image = await _imgPicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    if (image != null) {
      if (crop) {
        final cropped = await cropper(image);
        if (cropped != null) {
          return [
            File(cropped.path),
            image.name,
            image.path,
            File(cropped.path).lengthSync()
          ];
        } else {
          return null;
        }
      } else {
        return [
          File(image.path),
          image.name,
          image.path,
          File(image.path).lengthSync()
        ];
      }
    }
    return null;
  }

  Future<List?> pickVideoFromGallery({bool crop = false}) async {
    ImagePicker _imgPicker = ImagePicker();
    final image = await _imgPicker.pickVideo(source: ImageSource.gallery);
    if (image != null) {
      return [
        File(image.path),
        image.name,
        image.path,
        File(image.path).lengthSync()
      ];
    }

    return null;
  }
}

class AppCameraModuleExpection implements Exception {
  final String message;
  Exception? exception;

  AppCameraModuleExpection({required this.message, this.exception});
}
