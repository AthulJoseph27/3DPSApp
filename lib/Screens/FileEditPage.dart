import 'dart:io';

import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:print_shop/Theme.dart';
import 'dart:math';
import '../Globals.dart';

class FileEditPage extends StatefulWidget {
  final List<Map<String,dynamic>>fileData;
  const FileEditPage({Key key,this.fileData}) : super(key: key);

  @override
  _FileEditPageState createState() => _FileEditPageState();
}

class _FileEditPageState extends State<FileEditPage> {
  List<Map<String,dynamic>>filesData = [];
  List<bool>dismissed = [];
  List<TextEditingController> controllers = [];
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    if(filesData.isEmpty) {
      addFiles();
    }
    else {
      for (int i = 0; i < widget.fileData.length; i++) {
        filesData.add(widget.fileData[i]);
        dismissed.add(false);
        controllers.add(
            TextEditingController(text: filesData[i]['fileCount'].toString()));
      }
    }
    // for(int i=0;i<25;i++){
    // }
    super.initState();
  }

  String getFileSizeString({@required int bytes, int decimals = 0}) {
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  Map<String,String> getFileData(String path){
    Map<String,String>mp = Map();
    mp['fileName'] = path.split('/').last;
    mp['fileType'] = mp['fileName'].split('.').last.toUpperCase();
    mp['fileSize'] = getFileSizeString(bytes: File(path).lengthSync());
    return mp;
  }

  Future<void> _clearList(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor:
            lightTheme.value
                ? LightTheme.starWhite
                : DarkTheme.darkGray,
            title: Text(
              'Clear All?',
              style: TextStyle(fontSize: 20),
            ),
            content: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Spacer(
                    flex: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        filesData.clear();
                        dismissed.clear();
                        controllers.clear();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          'Yes',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          'No',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Widget> getBody(){
    List<Widget> w = [];
    for(int i=0;i<filesData.length;i++){
      if(dismissed[i])
        continue;
      Map<String,String>_fd = filesData[i];
      w.add(
        Card(
          child:Slidable(
            key: ValueKey(i),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                setState(() {
                  dismissed[i] = true;
                });
              }),
              children: const [
                SlidableAction(
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.clear,
                  label: 'Delete',
                ),
              ],
            ),
            endActionPane: const ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.view_in_ar,
                  label: 'View',
                ),
              ],
            ),
            child:  ListTile(
              leading: Icon(
                  Icons.insert_drive_file
              ),
              trailing: SizedBox(
                width: 30,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: controllers[i],
                  keyboardType: TextInputType.number,
                  // onFieldSubmitted: (val) {
                  //
                  //   print(controllers[i].value.text);
                  //   print('*'*20);
                  // },
                ),
              ),
              visualDensity: VisualDensity.compact,
              title: Text(_fd['fileName'],
                  style: TextStyle(
                      color: lightTheme.value
                          ? LightTheme.darkGray
                          : LightTheme.starWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat")),
              subtitle: Text(_fd['fileType']+"   "+_fd['fileSize'],
                  style: TextStyle(
                      color: lightTheme.value
                          ? LightTheme.darkGray
                          : LightTheme.starWhite,
                      fontFamily: "Montserrat")),
            ),
          ),
        )
      );
    }

    return w;
  }

  Future<void> addFiles()async{
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['stl', 'obj', 'mtl','amf','3mf','glTF','glb'],
      allowMultiple: true
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      files.forEach((element) {
        dismissed.add(false);
        filesData.add(getFileData(element.path));
        filesData.last['filePath'] = element.path;
        filesData.last['fileCount'] = '1';
        controllers.add(TextEditingController(text: '1'));
      });
      setState(() {
      });
    }
  }

  List<Map<String,dynamic>> getResult(){
    List<Map<String,dynamic>> result = [];
    for(int i=0;i<filesData.length;i++){
      if(dismissed[i]&&controllers[i].value.text.isNotEmpty)
        continue;

      int cnt = int.parse(controllers[i].value.text);

      if(cnt == 0)
        continue;

      cnt = max(1,min(999,cnt));

      filesData[i]['fileCount'] = cnt.toString();
      result.add(
        filesData[i]
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Add Files'),
        leading: IconButton(
          onPressed: (){
            filesData.clear();
            Navigator.pop(context,filesData);
          },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: LightTheme.darkGray.withOpacity(0.7),
            ),),
        actions:[
          IconButton(
            onPressed: (){
              Navigator.pop(context,getResult());
            },
            icon: Icon(
              Icons.check,
              color: LightTheme.darkGray.withOpacity(0.7),
            ),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getBody(),
        ),
      ),
    floatingActionButton:  AnimatedFloatingActionButton(
      //Fab list
        fabButtons: <Widget>[
          Container(
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: ()async{
                await _clearList(context);
              },
              child: Icon(
                Icons.clear_all
              ),
            ),
          ),
          Container(
            child: FloatingActionButton(
              heroTag: "btn2",
              onPressed: ()async{
                await addFiles();
              },
              child: Icon(
                  Icons.add
              ),
            ),
          ),
        ],
        key : fabKey,
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.menu_close //To principal button
    ),
    ));
  }
}
