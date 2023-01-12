import 'package:activity_5/pages/home_page.dart';
import 'package:flutter/material.dart';

void main () => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activity 5',
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      home: const HomePage(),
    );
  }
}
