import 'package:flutter/material.dart';
import 'package:chatgpt/home_page.dart';
import 'package:chatgpt/dio_helper.dart';

void main() {
  DioHelper.intDio();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
