import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatelessWidget {
  final String? imageUrl;
  final String? imagePath;
  final String? filePath;

  ImageScreen({
    this.imageUrl,
    this.imagePath,
    this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PhotoView(
                  imageProvider: NetworkImage(
                imageUrl!,
              )),
            )
          ],
        ),
      ),
    );
  }
}
