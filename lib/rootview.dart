import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fancy_bar/fancy_bar.dart';
import 'homeWidget.dart';
import 'registerWidget.dart';
import 'mineWidget.dart';


class rootViewWidget extends StatefulWidget {
  @override
  _rootViewWidgetState createState() => _rootViewWidgetState();
}

class _rootViewWidgetState extends State<rootViewWidget> {
  int _page = 0;
  List<Widget> _controller = [homeWidget(),registerWidget(),mineWidget()];
  @override
  Widget build(BuildContext context) {
    var _scaffold = Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text("22222"),
//      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recent_actors),
            title: Text("预约挂号"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("我的"),
          ),
        ],
        currentIndex: _page,
        onTap: (page) {
          setState(() {
            _page = page;
          });
        },
      ),
      body:IndexedStack(
        index: _page,
        children: _controller,
      ),
//      body: Center(
//        child: _controller[_page],
//        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
    return _scaffold;
  }
}


