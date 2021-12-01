import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:print_shop/Auth/Auth.dart';
import 'package:print_shop/Auth/AuthUser.dart';

import '../Globals.dart';
import '../Theme.dart';
import 'Home.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      body: StreamBuilder(
        stream: AuthService().user,
        builder: (context, snapshot) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height:height/2,
                      padding: const EdgeInsets.all(10),
                      child:SvgPicture.asset('assets/undraw_authentication_fsn5.svg'),
                    ),

                    Container(
                      width: width/1.2,
                      child: Text(
                        'A verification email has been send to your mail. Please verify to continue',
                        style: TextStyle(
                            color: lightTheme.value
                                ? LightTheme.darkGray
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 50,),
                    ClipRRect(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15)),
                      child: Container(
                        height: 50,
                        width: 250,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary:lightTheme.value
                              ? LightTheme.deepIndigoAccent
                              : DarkTheme.deepIndigoAccent,),
                          onPressed: ()async{
                            setState(() {
                              showLoading = true;
                            });
                            await AuthService().reloadUser();
                            setState(() {
                              showLoading = false;
                            });
                            if(snapshot.hasData && snapshot.data.emailVerified)
                              return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return Home(authUser: AuthUser(snapshot.data,""));}));
                          },
                          child: Center(
                            child: Text(
                              'Refresh',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500,
                                color: DarkTheme.darkGray,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              if (showLoading)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              if (showLoading)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          LightTheme.caribbeanGreen),
                    ),
                  ),
                )
            ],
          );
        }
      ),
    ),);
  }
}
