import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';
import 'text_post_screen.dart';
import 'video_post_screen.dart';
import 'image_post_screen.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Pass platform-specific options here
  );
  runApp(MindlinkApp());
}

class MindlinkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindlink Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    TextPostScreen(),
    VideoPostScreen(),
    ImagePostScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initDynamicLinks();
  }

  void _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? data) {
      final Uri? deepLink = data?.link;
      if (deepLink != null) {
        _handleDeepLink(deepLink);
      }
    }).onError((error) {
      print('Dynamic Link Failed: $error');
    });

    // Handle initial link if the app was opened via a dynamic link
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = initialLink?.link;
    if (deepLink != null) {
      _handleDeepLink(deepLink);
    }
  }

  void _handleDeepLink(Uri deepLink) {
    // Extract the 'postType' parameter to decide which page to show
    final postType = deepLink.queryParameters['postType'];
    if (postType == 'text') {
      setState(() {
        _selectedIndex = 0;
      });
    } else if (postType == 'video') {
      setState(() {
        _selectedIndex = 1;
      });
    } else if (postType == 'image') {
      setState(() {
        _selectedIndex = 2;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindlink Assignment'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Text Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Image Post',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
