import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:note_database/home/view/homePage.dart';
import 'package:note_database/home/view/splashScreen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: ()=>SplashScreen()),
        GetPage(name: '/home', page: ()=>HomePage()),
      ],
    ),
  );
}
