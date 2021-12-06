import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:print_shop/Screens/FileEditPage.dart';
import 'package:print_shop/Screens/FileViewer.dart';
import 'dart:io';

import '../Globals.dart';
import '../Theme.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  static List<Map<String,dynamic>> fileData = [];
  static double estimate = double.negativeInfinity;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool  showBodyError = false;

  List<Widget> getFileViews() {
    List<Widget> w = [];
    for (int i = 0; i < fileData.length; i++) {
      w.add(
        FileViewer(
              fileName: fileData[i]['fileName'],
              fileType: fileData[i]['fileType'],
              size: fileData[i]['fileSize'],
              count: fileData[i]['fileCount'],
      ));
    }
    
    w.add(SizedBox(height: 10,));
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            trailing: IconButton(
              onPressed: ()async{
                fileData = await Navigator.push(context, MaterialPageRoute(builder: (context){
                  return FileEditPage(fileData: fileData,);
                }));
                setState(() {
                });
              },
              icon: Icon(
                fileData.length == 0 ? Icons.add : Icons.edit
              ),
            ),
            title: Text('3D Files : ',
                style: TextStyle(
                    color: lightTheme.value
                        ? LightTheme.darkGray
                        : LightTheme.starWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                      color: lightTheme.value
                          ? LightTheme.darkGray.withOpacity(0.7)
                          : Colors.grey.withOpacity(0.7))),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: fileData.isEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                              height: 100,
                              child: SvgPicture.asset(
                                  'assets/undraw_add_files_re_v09g.svg')),
                          Spacer(),
                          Container(
                            child: Text(
                              'Add 3D Files',
                              style: TextStyle(
                                  color: lightTheme.value
                                      ? LightTheme.lightGray.withOpacity(0.7)
                                      : Colors.grey,
                                  fontSize: 18,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                        ],
                      ))
                  : Container(
                      height: 200,
                      child: ListView(
                        children: getFileViews(),
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text('Description : ',
                style: TextStyle(
                    color: lightTheme.value
                        ? LightTheme.darkGray
                        : LightTheme.starWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
//                    margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                      color: showBodyError
                          ? const Color(0xffd80000)
                          : _focusNode.hasFocus
                          ? LightTheme.caribbeanGreen
                          : (lightTheme.value
                          ? LightTheme.darkGray.withOpacity(0.7)
                          : Colors.grey.withOpacity(0.7)))),
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 2),
//                  color: lightTheme.value ? LightTheme.starWhite : DarkTheme.darkGray,
              child: Scrollbar(
                controller: _scrollController,
                radius: Radius.circular(10),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 12,
                    onChanged: (value) {
                    },
                    onEditingComplete: () {
                      _focusNode.unfocus();
                    },
                    onTap: () {},
                    onSubmitted: (value) {
                      _focusNode.unfocus();
                    },
                    decoration: InputDecoration(
                      errorText: showBodyError
                          ? "Message cannot be empty"
                          : null,
                      hintText:
                         'Type your message...',
                      hintStyle: TextStyle(
                          color: lightTheme.value
                              ? LightTheme.lightGray.withOpacity(0.7)
                              : Colors.grey,
                          fontSize: 16,
                          fontFamily: "Montserrat"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          estimate < 0 ?
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
                    'Get Estimate',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      color: DarkTheme.darkGray,
                    ),
                  ),
                ),
              ),
              onTap: (){
              },
            ),
          )
              :
          ListTile(
            title: Text('Price : ',
                style: TextStyle(
                    color: lightTheme.value
                        ? LightTheme.darkGray
                        : LightTheme.starWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"),),
          ),

        ],
      ),
    );
  }
}
