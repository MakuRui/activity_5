import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

enum ImageSection {
  noStoragePermission,
  noStoragePermissionPermanent,
  browseFiles,
  imageLoaded
}

class ImageModel extends ChangeNotifier {
  ImageSection _imageSection = ImageSection.browseFiles;

  ImageSection get imageSection => _imageSection;

  set imageSection(ImageSection value) {
    if (value != _imageSection) {
      _imageSection = value;
      notifyListeners();
    }
  }

  File? file;

  //Check if the permission is granted or not
  Future<bool> requestPermission() async {
    PermissionStatus result;
    result = await Permission.storage.request();

    if (result.isGranted) {
      imageSection = ImageSection.browseFiles;
      return true;
    } else if (result.isPermanentlyDenied) {
      imageSection = ImageSection.noStoragePermissionPermanent;
    } else {
      imageSection = ImageSection.noStoragePermission;
    }

    return false;
  }

  //If permission is granted we can pick a file specifically an image file
  Future<void> pickFile() async {
    final FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty &&
        result.files.single.path != null) {
      file = File(result.files.single.path!);
      _imageSection = ImageSection.imageLoaded;
    }
  }

}