import 'package:flutter/material.dart';
import 'package:test_project/views/home_view.dart';
import 'package:test_project/views/posts_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo Application',
      home: HomeView(),
    );
  }
}