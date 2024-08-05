import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const AgeDetectionApp());
}

class AgeDetectionApp extends StatelessWidget {
  const AgeDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Detection App',
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
