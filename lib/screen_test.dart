import 'package:flutter/material.dart';
import 'screens/textbook_page.dart'; // TextbookPage를 import합니다.

void main() {
  runApp(const ScreenTestApp());
}

class ScreenTestApp extends StatelessWidget {
  const ScreenTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TextbookPage(), // TextbookPage를 테스트합니다.
      debugShowCheckedModeBanner: false,
    );
  }
}
