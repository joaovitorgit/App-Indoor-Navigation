
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myflutterapp/view/view_inicial.dart';

import 'controller/controller_bluetooth.dart';
import 'controller/controller_distancia.dart';
import 'controller/controller_nodes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RequirementStateController());
    Get.put(RequirementDistance());
    Get.put(RequirementNode());
    final themeData = Theme.of(context);
    const primary = Colors.blue;

    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: primary,
        appBarTheme: themeData.appBarTheme.copyWith(
          elevation: 0.5,
          color: Colors.white,
          actionsIconTheme: themeData.primaryIconTheme.copyWith(
            color: primary,
          ),
          iconTheme: themeData.primaryIconTheme.copyWith(
            color: primary,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: primary,
      ),
      home: const HomePage(),
    );
  }
}
