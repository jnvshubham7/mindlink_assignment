import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class VideoPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.video_library, size: 100),
        Text('This is a video post.', style: TextStyle(fontSize: 24)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final String postLink = 'https://example.com/video-post';
            Share.share(postLink);
          },
          child: Text('Share Video Post'),
        ),
      ],
    );
  }
}
