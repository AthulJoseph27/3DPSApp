import 'package:flutter/material.dart';
import 'package:print_shop/Screens/VerifyEmail.dart';
import 'Auth.dart';
import 'package:print_shop/Screens/Home.dart';
import 'package:print_shop/Screens/Login.dart';
import 'package:print_shop/Screens/SignUp.dart';

import 'AuthUser.dart';

class Wrapper extends StatefulWidget {
  static String id = 'Wrapper';
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool hasAccount = true;

  void toggleView(){
    setState(() => hasAccount = !hasAccount);
  }
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (context, user){
        if(user.hasData) {
        if(!user.data.emailVerified)
          return VerifyEmail();
          return Home(authUser: AuthUser(user:user.data,role:"",error:""));
        }
        else {
          if(hasAccount)
            return Login(toggleView: toggleView);
          else
            return SignUp(toggleView: toggleView);
        }
      },
    );
  }
}