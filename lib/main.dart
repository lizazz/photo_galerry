import 'dart:io';
import 'package:flutter/material.dart';
import 'photos/Photos.dart';
import 'utils.dart' as utils;

void main() {
  startMeUp() async {
    runApp(PhotoGallery());
  }

  startMeUp();
}

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Photo Gallery"),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.photo_album),
                  text: 'Photos',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Photos()
            ],
          ),
        ),
      )
    );
  }
}
