import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_me/screens/bookmarks.dart';
import 'package:news_me/screens/browse.dart';
import 'package:news_me/screens/channels.dart';
import 'package:news_me/screens/home.dart';
import 'package:news_me/screens/preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    HomeScreen(
      key: PageStorageKey('HomeScreen'),
    ),
    BrowseScreen(
      key: PageStorageKey('BrowseScreen'),
    ),
    BookmarkScreen(
      key: PageStorageKey('BookmarkScreen'),
    ),
    ChannelScreen(
      key: PageStorageKey('ChannelScreen'),
    ),
    PreferenceScreen(
      key: PageStorageKey('PreferenceScreen'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget _buildBottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: TextStyle(
          fontFamily: 'Rubik'
        ),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(LineIcons.home),title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(LineIcons.newspaper_o), title: Text('Browse')),
          BottomNavigationBarItem(icon: Icon(LineIcons.bookmark), title: Text('Bookmarks')),
          BottomNavigationBarItem(icon: Icon(LineIcons.globe), title: Text('Sources')),
          BottomNavigationBarItem(icon: Icon(LineIcons.user), title: Text('Preferences'))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(_selectedIndex),
      body: PageStorage(
        bucket: bucket,
        child: pages[_selectedIndex],
      ),
    );
  }
}
