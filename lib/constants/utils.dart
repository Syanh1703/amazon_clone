import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackbar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar
    (content: Text(content),
  ),
  );
}

//30_07: Pick Image
Future<List<File>> pickImages() async {
  List<File> images = [];
  try{
      FilePickerResult? filePiker = await FilePicker.platform.pickFiles(
        type: FileType.image, //Filter out the image file only
        allowMultiple: true,
      );
      if(filePiker != null && filePiker.files.isNotEmpty){
        for(int i = 0; i < filePiker.files.length; i++){
          //Add all the files to the image list
          images.add(File(filePiker.files[i].path!));
        }
        //images = filePiker.paths.map((path) => File(path!)).toList();
      }
  }catch(error){
    debugPrint(error.toString());
  }
  return images;
}