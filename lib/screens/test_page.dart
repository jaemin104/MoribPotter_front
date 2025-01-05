import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  Future<void> _testServerConnection(BuildContext context) async {
    final url = Uri.parse('http://172.10.7.89/test'); // 서버의 테스트 엔드포인트
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // 서버 응답이 성공적일 경우
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('서버 응답: ${response.body}')),
        );
      } else {
        // 서버가 응답했지만 성공하지 못한 경우
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('서버 오류: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // 네트워크 요청 실패 (서버 접속 불가 등)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('네트워크 오류: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('서버 연결 테스트')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _testServerConnection(context),
          child: const Text('서버 연결 확인'),
        ),
      ),
    );
  }
}
