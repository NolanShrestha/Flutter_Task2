import 'package:flutter/material.dart';
import 'screens/page1.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PageTheme.getDarkTheme(),
      home: const Page1(),
    );
  }
}
