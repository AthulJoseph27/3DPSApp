import 'package:flutter/material.dart';
import 'package:print_shop/Auth/AuthUser.dart';

import 'AdminHome.dart';
import 'CustomerHome.dart';

class Home extends StatefulWidget {
  final AuthUser authUser;
  const Home({Key key,this.authUser}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool loading = true;

  @override
  void initState() {
    if(widget.authUser.role.isEmpty){
      //get role
    }
    setState(() {
      loading = false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.authUser.role == 'Admin')
      return AdminHome();
    return CustomerHome();
  }
}
