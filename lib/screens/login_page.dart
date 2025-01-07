import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../user_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _loginWithKakao(BuildContext context) async {
    try {
      await UserApi.instance.loginWithKakaoAccount();

      // 카카오톡 앱 로그인 또는 계정 로그인
      /*
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      */

      // 사용자 정보 가져오기
      User user = await UserApi.instance.me();
      final nickname = user.kakaoAccount?.profile?.nickname;

      if (nickname == null) {
        throw Exception('닉네임을 가져올 수 없습니다.');
      }

      // 전역 상태 접근
      final userState = Provider.of<UserState>(context, listen: false);

      // 전역 상태에 닉네임 저장
      userState.setNickname(nickname);

      // 서버로 닉네임 확인 요청
      final checkResponse = await http.post(
        Uri.parse('http://172.10.7.89/auth/check_dorm'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      if (checkResponse.statusCode == 200) {
        final responseData = jsonDecode(checkResponse.body);

        if (responseData['status'] == 'existing_user') {
          // 기존 사용자인 경우
          userState.setDorm(responseData['dorm']); // 서버에서 받은 dorm 정보 설정장
          Navigator.pushNamed(context, '/home');
        } else if (responseData['status'] == 'new_user') {
          // 새 사용자인 경우
          final saveResponse = await http.post(
            Uri.parse('http://172.10.7.89/auth/save'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'nickname': nickname}),
          );
          if (saveResponse.statusCode == 200) {
            Navigator.pushNamed(context, '/survey');
          } else {
            throw Exception('닉네임 저장 실패: ${saveResponse.body}');
          }
        }
      } else {
        throw Exception('닉네임 확인 실패: ${checkResponse.body}');
      }
    } catch (e) {
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
