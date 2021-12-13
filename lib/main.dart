import 'package:flutter/material.dart';
import 'package:setstate_pattern/pages/create_post_page.dart';
import 'package:setstate_pattern/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.id : (context) => HomePage(),
        CreatePost.id : (context) => CreatePost(),
      },
    );
  }
}