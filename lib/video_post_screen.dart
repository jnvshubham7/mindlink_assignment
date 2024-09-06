import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
          onPressed: () async {
            final dynamicLink = await _createDynamicLink('video');
            Share.share(dynamicLink.toString());
          },
          child: Text('Share Video Post'),
        ),
      ],
    );
  }

  Future<Uri> _createDynamicLink(String postType) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://yourapp.page.link', // Replace with your Dynamic Link domain
      link: Uri.parse('https://yourapp.com/post?postType=$postType'), // Replace with your website URL
      androidParameters: AndroidParameters(
        packageName: 'com.example.yourapp', // Replace with your app's package name
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.yourapp', // Replace with your iOS bundle ID
        minimumVersion: '1.0.1',
        appStoreId: '123456789', // Replace with your app's App Store ID
      ),
    );

    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortDynamicLink.shortUrl;
  }
}
