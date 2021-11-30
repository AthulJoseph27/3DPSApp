import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:print_shop/Auth/Auth.dart';
import '../Globals.dart';
import '../Theme.dart';
import 'Loading.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});
  static String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  int page = 0;
  String phoneNo = "";
  String password = "";
  bool loading = false;
  bool showLoading = false;
  String error = "";
  AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    if (_height < 600) _height = 600;
    double _width = MediaQuery.of(context).size.width;
    return loading
        ? WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(key: scaffoldKey, body: Loading()))
        : SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                  key: scaffoldKey,
                  backgroundColor: lightTheme.value
                      ? LightTheme.starWhite
                      : DarkTheme.darkGray,
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Container(
                            height: _height,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: _height / 4,
                                  width: _width,
                                  child: SvgPicture.asset(
                                    'assets/undraw_authentication_fsn5.svg',
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
                                        'Login',
                                        style: TextStyle(
                                            color: lightTheme.value
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
                                        'Please Sign In to continue',
                                        maxFontSize: 14,
                                        minFontSize: 14,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: lightTheme.value
                                                ? LightTheme.darkGray
                                                    .withOpacity(0.8)
                                                : Colors.white30,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 14),
                                        overflowReplacement: Text(
                                          'Please Sign In to continue',
                                          style: TextStyle(
                                              color: lightTheme.value
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
                                  child: Container(
                                    height: 50,
                                    width: 300,
                                    color: lightTheme.value
                                        ? LightTheme.darkGray.withOpacity(0.3)
                                        : Colors.white10,
                                    padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                                    child: TextFormField(
                                      style: TextStyle(
                                          color: lightTheme.value
                                              ? LightTheme.darkGray
                                              : Colors.white70,
                                          fontSize: 14),
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        icon: Container(
                                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                                          child: Icon(
                                            Icons.phone,
                                            color: lightTheme.value
                                                ? LightTheme.darkGray
                                                : Colors.white70,
                                            size: 20,
                                          ),
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                            color: lightTheme.value
                                                ? LightTheme.darkGray
                                                    .withOpacity(0.7)
                                                : Colors.white70,
                                            fontFamily: "Montserrat"),
                                        filled: false,
                                      ),
                                      validator: (val) => val.isEmpty
                                          ? "Enter a valid phone number"
                                          : null,
                                      onChanged: ((val) {
                                        setState(() {
                                          phoneNo = val;
                                          return phoneNo;
                                        });
                                      }),
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
                                    color: lightTheme.value
                                        ? LightTheme.darkGray.withOpacity(0.3)
                                        : Colors.white10,
                                    padding: EdgeInsets.fromLTRB(10, 2, 5, 5),
                                    child: TextFormField(
                                      style: TextStyle(
                                          color: lightTheme.value
                                              ? LightTheme.darkGray
                                              : Colors.white70,
                                          fontFamily: "Montserrat",
                                          fontSize: 14),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        icon: Container(
                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Icon(
                                            Icons.vpn_key,
                                            color: lightTheme.value
                                                ? LightTheme.darkGray
                                                : Colors.white70,
                                            size: 20,
                                          ),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            color: lightTheme.value
                                                ? LightTheme.darkGray
                                                    .withOpacity(0.7)
                                                : Colors.white70,
                                            fontFamily: "Montserrat"),
                                        filled: false,
                                      ),
                                      obscureText: true,
                                      validator: (val) => val.length < 6
                                          ? 'Password is not valid'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          password = val;
                                          return password;
                                        });
                                      },
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
                                      color: lightTheme.value
                                          ? LightTheme.deepIndigoAccent
                                          : DarkTheme.deepIndigoAccent,
                                      height: 50,
                                      width: 250,
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500,
                                            color: DarkTheme.darkGray,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      setState(() {
                                        showLoading = true;
                                      });

                                      if (_formKey.currentState.validate()) {
                                        dynamic result =
                                            await _auth.loginWithEmailAndPassword(
                                                phoneNo, password);
                                        if (result.user == null) {
                                          setState(() {
                                            showLoading  = false;
                                          });
                                          if (result.error == "user-not-found") {
                                            error = 'Invalid credentials';
                                          } else {
                                            error = "Can't connect to the network";
                                          }
                                          scaffoldKey.currentState.showSnackBar(
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
                                      } else {
                                        setState(() {
                                          showLoading  = false;
                                        });
                                        error = 'Invalid credentials';
                                        scaffoldKey.currentState.showSnackBar(
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
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  child: Row(
                                    children: <Widget>[
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 170,
                                        child: Center(
                                          child: Text(
                                            "Don't have an account?",
                                            style: TextStyle(
                                                color: lightTheme.value
                                                    ? LightTheme.darkGray
                                                        .withOpacity(0.7)
                                                    : Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          widget.toggleView();
                                        },
                                        child: Container(
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: lightTheme.value
                                                      ? LightTheme.darkGray
                                                          .withOpacity(0.7)
                                                      : Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
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
                                  style: ElevatedButton.styleFrom(primary:lightTheme.value?LightTheme.starWhite:DarkTheme.darkGray),
                                  onPressed: ()async {
                                    setState(() {
                                      showLoading = true;
                                    });
                                    var res = await _auth.loginWithGoogle();
                                    print(res.user);
                                    print("%"*20);
                                    setState(() {
                                      showLoading  = false;
                                    });
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      padding: const EdgeInsets.all(10),
                                      child: Image(
                                        image:
                                            Image.asset('assets/google.png').image,
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
                  ),
            ),
          ),);
  }
}
