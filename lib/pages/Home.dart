import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/pages/PlaceHolderWidget.dart';

import 'MyHomePage.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  int _currentIndex = 0;
  final List<Widget> _children= [
    MyHomePage(),
    PlaceHolderWidget(Colors.deepOrange),
    PlaceHolderWidget(Colors.amberAccent)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: ConvexAppBar(
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.search, title: 'Explore'),
              TabItem(icon: Icons.people, title: 'Profile'),
            ],
            initialActiveIndex : _currentIndex,
            backgroundColor: Colors.green,
            style: TabStyle.textIn,
            onTap: onTabTapped,
        )
    );
  }

  void onTabTapped(int index){
    setState((){
      _currentIndex = index;
    });
  }
}