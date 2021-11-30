import 'package:flutter/material.dart';

import '../Theme.dart';

class Loading extends StatelessWidget {
  static String id = 'Loading';
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    if(_height < 600)
      _height = 600;
    return Scaffold(
        backgroundColor: true ? LightTheme.starWhite : DarkTheme.darkGray,
        body:SingleChildScrollView(
          child: Container(
            height: _height,
            child: Column(
              children: [
                Spacer(flex: 6,),
                Container(
                  height: 300,
                  //child: //Lottie.asset('assets/lottieAnimation.json'),
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(LightTheme.caribbeanGreen),
                ),
                Spacer(flex: 4,),
                Spacer(),
              ],
            ),
          ),
        )
    );
  }
}