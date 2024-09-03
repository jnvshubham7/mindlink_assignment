import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class TextPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This is a text post.', style: TextStyle(fontSize: 24)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final String postLink = 'https://example.com/text-post';
            Share.share(postLink);
          },
          child: Text('Share Text Post'),
        ),
      ],
    );
  }
}
