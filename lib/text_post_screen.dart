import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
          onPressed: () async {
            final dynamicLink = await _createDynamicLink('text');
            Share.share(dynamicLink.toString());
          },
          child: Text('Share Text Post'),
        ),
      ],
    );
  }

  Future<Uri> _createDynamicLink(String postType) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://yourapp.page.link',
      link: Uri.parse('https://yourapp.com/post?postType=$postType'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.yourapp',
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.yourapp',
        minimumVersion: '1.0.1',
        appStoreId: '123456789',
      ),
    );

    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortDynamicLink.shortUrl;
  }
}
