import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:flutter/material.dart';

import 'find/find_page.dart';
import 'home/home_page.dart';
import 'message/message_dart.dart';
import 'mine/mine_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainStatePage createState() {
    return _MainStatePage();
  }
}

class _MainStatePage extends State<MainPage> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    GmLocalization gm= GmLocalization.of(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        //禁止滑动
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          FindPage(),
          MessagePage(),
          MinePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items:[
          _bottomNavigationBar(gm.home, Icons.home, 0),
          _bottomNavigationBar(gm.find, Icons.search, 1),
          _bottomNavigationBar(gm.message, Icons.message, 2),
          _bottomNavigationBar(gm.mine, Icons.person, 3),

        ],
      ),
    );
  }

  _bottomNavigationBar(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor,),
        activeIcon: Icon(icon, color: _activeColor,),
        title: Text(title, style: TextStyle(
            color: _currentIndex != index ? _defaultColor : _activeColor),)
    );
  }
}
