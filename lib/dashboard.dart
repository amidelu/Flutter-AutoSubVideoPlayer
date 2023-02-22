import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sub_video_player/util/logger.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Getting video file path
  List<FileSystemEntity> _files = [];
  List<String> ext = [
    ".3g2",
    ".3gp",
    ".asf",
    ".asx",
    ".avi",
    ".flv",
    ".m2ts",
    ".mkv",
    ".mov",
    ".mp4",
    ".mpg",
    ".mpeg",
    ".rm",
    ".swf",
    ".vob",
    ".wmv"
  ];

  void _getFiles() async {
    // List<Directory>? directories = await getExternalStorageDirectories();
    final Directory root = Directory('/storage/emulated/0/');
    final Directory? external = await getExternalStorageDirectory();
    logger.i('External Storage path', external);

    List<FileSystemEntity> files = root
        .listSync(recursive: true)
        .where((element) =>
            element.path.endsWith('.mp4') || element.path.endsWith('.mkv'))
        .toList();

    List<FileSystemEntity> externalFiles = [];
    if (external != null) {
      externalFiles = external
          .listSync(recursive: true)
          .where((element) =>
              element.path.endsWith('mp4') || element.path.endsWith('mkv'))
          .toList();
    }

    setState(() {
      _files = [...files, ...externalFiles];
      logger.d('file path', _files);
    });
  }

  void _checkPermission() async {
    if (await Permission.storage.request().isGranted) {
      _getFiles();
    } else {
      await Permission.storage.request().then((value) {
        if (value.isGranted) {
          _getFiles();
        } else if (value.isDenied) {
          // show alert that permission is necessary
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: _files.length,
        itemBuilder: (BuildContext context, int index) {
          return const ListTile();
        },
      ),
    );
  }
}
