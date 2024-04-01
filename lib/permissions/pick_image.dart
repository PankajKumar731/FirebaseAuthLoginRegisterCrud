import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  void pickImage() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload image")),
      body: Column(
        children: [
          GestureDetector(
              onTap: () async {
                if (Platform.isAndroid) {
                  final androidInfo = await DeviceInfoPlugin().androidInfo;
                  if (androidInfo.version.sdkInt <= 32) {
                    /// use [Permissions.storage.status]
                    await Permission.storage.onDeniedCallback(() {
                      // Your code
                    }).onGrantedCallback(() {
                      pickImage();
                    }).onPermanentlyDeniedCallback(() {
                      // Your code
                      openAppSettings();
                    }).onRestrictedCallback(() {
                      // Your code
                    }).onLimitedCallback(() {
                      // Your code
                    }).onProvisionalCallback(() {
                      // Your code
                    }).request();
                  } else {
                    /// use [Permissions.photos.status]
                    await Permission.photos.onDeniedCallback(() {
                      // Your code
                    }).onGrantedCallback(() {
                      pickImage();
                    }).onPermanentlyDeniedCallback(() {
                      // Your code
                      openAppSettings();
                    }).onRestrictedCallback(() {
                      // Your code
                    }).onLimitedCallback(() {
                      // Your code
                    }).onProvisionalCallback(() {
                      // Your code
                    }).request();
                  }
                }
              },
              child: Text("upload image")),
          Image.network(
              width: 200,
              height: 200,
              "https://firebasestorage.googleapis.com/v0/b/first-project-cd333.appspot.com/o/insta%20(2).png?alt=media&token=e9490703-1ee7-4214-97ed-40f98ee9968d"),
        ],
      ),
    );
  }
}
