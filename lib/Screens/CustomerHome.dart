import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../Theme.dart';
import 'OrderPage.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key key}) : super(key: key);

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

/*
  Tabs -> orders, place new order, home/info page
*/

class _CustomerHomeState extends State<CustomerHome> {
  int _page = 1;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Widget getBody(int index){
    if(index == 2)
        return OrderPage();
    return Container(color: Colors.blue,);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.history, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.add_box_outlined, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: LightTheme.deepIndigoAccent,
          backgroundColor: LightTheme.starWhite,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        appBar: AppBar(
          title: Text('Project Faction')
          ,
        ),
        body: getBody(_page)
      ),
    );
  }
}
