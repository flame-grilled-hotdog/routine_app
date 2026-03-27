import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:routine_app/screen/app.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

void main() {
  if(kIsWeb){
    ;
  }else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}
