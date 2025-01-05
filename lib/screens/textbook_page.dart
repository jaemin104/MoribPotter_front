import 'package:flutter/material.dart';

class TextbookPage extends StatelessWidget {
  const TextbookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Textbook'),
      ),
      body: const Center(
        child: Text(
          '이곳은 교재 페이지입니다.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
