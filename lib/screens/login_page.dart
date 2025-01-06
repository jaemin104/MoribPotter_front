import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _startKakaoLogin(BuildContext context) async {
    try {
      // 서버의 /auth/kakao로 요청
      final url = Uri.parse('http://172.10.7.89/auth/kakao'); // 서버 주소
      if (await canLaunchUrl(url)) {
        // 카카오 인증 URL로 리다이렉트
        await launchUrl(url);
      } else {
        throw Exception('카카오 인증 URL을 열 수 없습니다.');
      }
    } catch (e) {
      // 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('카카오 로그인 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('카카오 로그인')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _startKakaoLogin(context),
          child: const Text('카카오 로그인'),
        ),
      ),
    );
  }
}
