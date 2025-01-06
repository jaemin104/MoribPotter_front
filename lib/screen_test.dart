import 'package:flutter/material.dart';
import 'screens/potion_exam_page.dart';

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
      home: const PotionExamPage(), // TextbookPage를 테스트합니다.
      debugShowCheckedModeBanner: false,
    );
  }
}
