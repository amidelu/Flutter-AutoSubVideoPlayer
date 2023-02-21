import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sub_video_player/util/logger.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Getting video file path
  List<FileSystemEntity> _files = [];

  void _getFiles() async {
    Directory? directory = await getDownloadsDirectory();
    List<FileSystemEntity> files = directory!
        .listSync(recursive: true)
        .where((element) => element.path.endsWith('.mp4'))
        .toList();

    setState(() {
      _files = files;
      logger.d('file path', _files);
    });
  }

  @override
  void initState() {
    super.initState();
    _getFiles();
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
