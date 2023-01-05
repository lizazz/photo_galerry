import 'dart:io';
import 'package:flutter/material.dart';
import 'photos/Photos.dart';

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
      title: 'Photo Gallery',
      home:  Scaffold(
        appBar: AppBar(title: const Text('Photo Gallery')),
          body: Center(
            child: Card(
              child: Photos(),
            )
          ),
      )
    );
  }
}
