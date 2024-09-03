import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ImagePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image, size: 100),
        Text('This is an image post.', style: TextStyle(fontSize: 24)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final String postLink = 'https://example.com/image-post';
            Share.share(postLink);
          },
          child: Text('Share Image Post'),
        ),
      ],
    );
  }
}
