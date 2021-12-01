import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:print_shop/Auth/Auth.dart';
import '../Globals.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Loading.dart';
import '../Theme.dart';

class SignUp extends StatefulWidget {
  static String id = 'SignUp';
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  String password = "";
  String userName = "";
  bool loading = false;
  String error = "";
  bool showLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    if (_height < 600) _height = 600;
    double _width = MediaQuery.of(context).size.width;
//    BuildContext widgetContext = context;
    return loading
        ? Loading()
        : SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: lightTheme.value
                    ? LightTheme.starWhite
                    : DarkTheme.darkGray,
                body: ValueListenableBuilder(
                  valueListenable: lightTheme,
                  builder: (BuildContext context, bool value, Widget child) {
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Container(
                              height: _height,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: _height / 4,
                                    width: _width,
                                    child: SvgPicture.asset(
                                      'assets/undraw_enter_uhqk.svg',
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 60),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: value
                                                  ? LightTheme.darkGray
                                                  : Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Montserrat",
                                              fontSize: 26),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 60),
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          'Please Sign Up to continue',
                                          maxLines: 1,
                                          maxFontSize: 14,
                                          minFontSize: 14,
                                          style: TextStyle(
                                              color: value
                                                  ? LightTheme.darkGray
                                                      .withOpacity(0.8)
                                                  : Colors.white30,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Montserrat",
                                              fontSize: 14),
                                          overflowReplacement: Text(
                                            'Please Sign Up to continue',
                                            style: TextStyle(
                                                color: value
                                                    ? LightTheme.darkGray
                                                        .withOpacity(0.8)
                                                    : Colors.white30,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Montserrat",
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: SizedBox(
                                      child: Container(
                                        height: 50,
                                        width: 300,
                                        color: value
                                            ? LightTheme.darkGray
                                                .withOpacity(0.2)
                                            : Colors.white10,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 2, 2, 5),
                                        child:TextFormField(
                                          style: TextStyle(
                                              color: value
                                                  ? LightTheme.darkGray
                                                  : Colors.white70,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 10.0),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            icon: Container(
                                              padding:
                                              EdgeInsets.fromLTRB(0, 6, 0, 0),
                                              child: Icon(
                                                Icons.mail,
                                                color: value
                                                    ? LightTheme.darkGray
                                                    : Colors.white70,
                                                size: 20,
                                              ),
                                            ),
                                            hintText: 'Email',
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                color: value
                                                    ? LightTheme.darkGray
                                                    .withOpacity(0.7)
                                                    : Colors.white70,
                                                fontFamily: "Montserrat"),
                                            filled: false,
                                          ),
                                          validator: (val) {
                                            if (val.isEmpty) {}
                                            return null;
                                          },
                                          onChanged: ((val) {
                                            setState(() {
                                              userName = val;
                                              return userName;
                                            });
                                          }),
                                          keyboardType:
                                          TextInputType.emailAddress,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Container(
                                      height: 50,
                                      width: 300,
                                      color: value
                                          ? LightTheme.darkGray.withOpacity(0.2)
                                          : Colors.white10,
                                      padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                                      child: TextFormField(
                                        obscureText: true,
                                        style: TextStyle(
                                            color: value
                                                ? LightTheme.darkGray
                                                : Colors.white70,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          icon: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 6, 0, 0),
                                            child: Icon(
                                              Icons.vpn_key,
                                              color: value
                                                  ? LightTheme.darkGray
                                                  : Colors.white70,
                                              size: 20,
                                            ),
                                          ),
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                              fontSize: 15,
                                              color: value
                                                  ? LightTheme.darkGray
                                                      .withOpacity(0.7)
                                                  : Colors.white70,
                                              fontFamily: "Montserrat"),
                                          filled: false,
                                        ),
                                        validator: (val) {
                                          if (val.isEmpty) {}
                                          return null;
                                        },
                                        onChanged: ((val) {
                                          setState(() {
                                            password = val;
                                            return password;
                                          });
                                        }),
                                        keyboardType:
                                            TextInputType.text,
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: GestureDetector(
                                      child: Container(
                                        color: value
                                            ? LightTheme.deepIndigoAccent
                                            : DarkTheme.deepIndigoAccent,
                                        height: 50,
                                        width: 250,
                                        child: Center(
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              color: DarkTheme.darkGray,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            showLoading = true;
                                          });
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  userName, password);
                                          setState(() {
                                            showLoading = false;
                                          });
                                          if (result.user == null) {
                                            if (result.error ==
                                                "user-not-found") {
                                              error = 'Invalid credentials';
                                            } else {
                                              error =
                                                  "Can't connect to the network";
                                            }
                                            _scaffoldKey.currentState
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  error,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                      fontFamily: "Montserrat"),
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          setState(() {
                                            showLoading = false;
                                          });
                                          error = 'Invalid credentials';
                                          _scaffoldKey.currentState
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                error,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    fontFamily: "Montserrat"),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: Row(
                                      children: [
                                        Spacer(flex: 1),
                                        Container(
                                          height: 40,
                                          width: 180,
                                          child: Center(
                                            child: Text(
                                              "Already have an account?",
                                              style: TextStyle(
                                                  color: value
                                                      ? LightTheme.darkGray
                                                          .withOpacity(0.7)
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontFamily: "Montserrat"),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            widget.toggleView();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 50,
                                            child: Center(
                                              child: Text(
                                                "Login",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: value
                                                        ? LightTheme.darkGray
                                                            .withOpacity(0.7)
                                                        : Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    fontFamily: "Montserrat"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Stack(
                                      children: [
                                        Center(
                                            child: Divider(
                                          thickness: 2,
                                          indent: 20,
                                          endIndent: 20,
                                        )),
                                        Center(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 100,
                                            color: lightTheme.value
                                                ? LightTheme.starWhite
                                                : DarkTheme.darkGray,
                                            child: Text("Or Sign In with"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: lightTheme.value
                                            ? LightTheme.starWhite
                                            : DarkTheme.darkGray),
                                    onPressed: () async {
                                      setState(() {
                                        showLoading = true;
                                      });
                                      var res = await _auth.loginWithGoogle();
                                      print(res.user);
                                      print("%" * 20);
                                      setState(() {
                                        showLoading = false;
                                      });
                                    },
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        padding: const EdgeInsets.all(10),
                                        child: Image(
                                          image:
                                              Image.asset('assets/google.png')
                                                  .image,
                                        )),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
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
                  },
                ),
              ),
            ),
          );
  }
}
