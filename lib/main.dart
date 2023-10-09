import 'dart:convert';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutt_folio/src/classes/flutt_folio.dart';
import 'package:flutt_folio/src/classes/parser/ink_well.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

final FluttFolio fluttFolioClass = FluttFolio();

void main() async {
  // add the Custom Widget Parsers to dynamically build the widgets
  DynamicWidgetBuilder.addParser(InkWellParser());

  // make sure the app is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // try loading the settings and layout json files
  Map<String, dynamic> settings = {"isEditMode": false, "title": "FluttFolio"};
  try {
    settings = jsonDecode(await rootBundle.loadString('assets/settings.json'));
  } catch (e) {
    if (kDebugMode) {
      print("loading settings.json failed: $e");
    }
  }

  bool isEditMode = settings["isEditMode"];
  Map<String, dynamic> layout = {};
  try {
    layout = jsonDecode(await rootBundle.loadString('assets/layout.json'));
  } catch (e) {
    isEditMode = true;
    if (kDebugMode) {
      print("loading layout.json failed: $e");
    }
  }

  if (layout.isEmpty) {
    isEditMode = true;
  }

  // TODO: implement theme loading from theme.json

  // initialize the FluttFolio class
  fluttFolioClass.initialize(layout, settings, isEditMode);

  // run the app in a ChangeNotifierProvider
  runApp(ChangeNotifierProvider(
      create: (context) => fluttFolioClass, child: const MyApp()));
}
