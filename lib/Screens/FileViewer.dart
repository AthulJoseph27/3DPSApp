import 'package:flutter/material.dart';

import '../Globals.dart';
import '../Theme.dart';

class FileViewer extends StatelessWidget {
  final String fileName,fileType, size;
  const FileViewer({Key key,this.fileName,this.fileType,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: LightTheme.deepIndigoAccent.withOpacity(0.9),
          child: ListTile(
            leading: Icon(
              Icons.insert_drive_file
            ),
            visualDensity: VisualDensity.compact,
            title: Text(fileName,
                style: TextStyle(
                    color: lightTheme.value
                        ? LightTheme.darkGray
                        : LightTheme.starWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat")),
            subtitle: Text(fileType+"   "+size,
                style: TextStyle(
                    color: lightTheme.value
                        ? LightTheme.darkGray
                        : LightTheme.starWhite,
                    fontFamily: "Montserrat")),
          ),
        ),
      ),
    );
  }
}
