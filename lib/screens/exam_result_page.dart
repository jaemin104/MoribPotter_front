import 'package:flutter/material.dart';

class ExamResultPage extends StatelessWidget {
  const ExamResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Exam Page'),
        backgroundColor: Colors.blue, // AppBar 색상
      ),
      body: Center(
        child: Text(
          'Real Exam Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
