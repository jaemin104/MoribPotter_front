import 'dart:convert'; // JSON 인코딩 및 디코딩
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP 요청 처리
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'; // 카카오 SDK

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _loginWithKakao(BuildContext context) async {
    try {
      // 카카오톡 앱 로그인 또는 계정 로그인
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }

      // 사용자 정보 가져오기
      User user = await UserApi.instance.me();
      final nickname = user.kakaoAccount?.profile?.nickname;

      // 서버로 닉네임 저장 요청
      final response = await http.post(
        Uri.parse('http://172.10.7.89/auth/save'), // 서버 엔드포인트
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      // 서버 저장 성공 여부 확인 후 페이지 이동
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/logout', arguments: {'nickname': nickname});
      } else {
        throw Exception('서버 오류: ${response.body}');
      }
    } catch (e) {
      // 로그인 실패 처리
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
          onPressed: () => _loginWithKakao(context),
          child: const Text('카카오 로그인'),
        ),
      ),
    );
  }
}
