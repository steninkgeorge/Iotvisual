import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotdashnew/screen/auth.dart';
import 'dart:js' as js;

import 'package:iotdashnew/screen/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool cookieExists = checkCookieExists();

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {'/home': (context) => Home(), '/auth': (context) => Auth()},
        home: cookieExists ? Home() : const Auth());
  }

  bool checkCookieExists() {
    final String cookie = js.context['document'].cookie;

    return cookie.contains('_id=') &&
        cookie.split('_id=').last.trim().isNotEmpty;
  }
}
