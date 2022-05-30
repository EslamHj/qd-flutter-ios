// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:get/get.dart';
// import 'package:pro_delivery/coponents/darkMode.dart';

// class darkService {
//   Future<String> get getLocalPath async {
//     var folder = await getApplicationDocumentsDirectory();
//     return folder.path;
//   }

//   Future<File> getLocalFile() async {
//     String Path = await getLocalPath;
//     return File('$Path/darkMode.txt');
//   }

//   Future<File> writedarkMode(String v) async {
//     File file = await getLocalFile();
//     return file.writeAsString(v);
//   }

//   Future<String> readedarkMode() async {
//     final file = await getLocalFile();
//     String content = await file.readAsString();
//     return content;
//   }

//    readeMain() async {
//     final file = await getLocalFile();
//     String content = await file.readAsString();
  
//   return content ;
    
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_delivery/coponents/darkMode.dart';

class darkService {
  final _box = GetStorage();
  final _Key = "isDarkMode";

  // ThemeMode getThemeMode(){
  // return _loadThemeFrombox() ? ThemeMode.light : ThemeMode.dark;
  // }
  // bool _loadThemeFrombox() => _box.read(_Key) ?? false ;
  // ThemeMode get theme => _loadThemeFrombox() ? ThemeMode.light : ThemeMode.dark;

///write
  void saveThemeMode(bool isDarkMode){
    // isDarkMode == null ?  isDarkMode = false : isDarkMode = isDarkMode ;
    _box.write(_Key, isDarkMode);
  }

  //   read(key)async{
  //   bool value = await _box.read(_Key);
  //   return value;
  // }


  // void switchTheme(){
  //   Get.changeThemeMode(_loadThemeFrombox() ? ThemeMode.light : ThemeMode.dark);
  //   saveThemeMode(!_loadThemeFrombox());
  // }

}