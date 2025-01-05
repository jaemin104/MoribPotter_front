import 'package:flutter/material.dart';

class PotionExamPage extends StatelessWidget {
  const PotionExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('시험장'),
      ),
      body: const Center(
        child: Text('시험장 화면'),
      ),
    );
  }
}
