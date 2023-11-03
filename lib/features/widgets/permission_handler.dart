// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermissionHandler {
  final BuildContext context;

  StoragePermissionHandler(this.context);

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      PermissionStatus result = await Permission.manageExternalStorage.request();

      if (result.isGranted) {
        print("Permission Request has submitted!");
      } else {
        print("Permission Request has denied by user!");
      }
    }
  }
}