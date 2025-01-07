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
    // 위치 조정을 위한 매개변수
    // 위 -1.0, 아래 1.0
    final double potterVerticalOffset = 0.05; // morib_potter.png Y축 위치 조정
    final double subtitleVerticalOffset = 0.2; // subtitle.png Y축 위치 조정
    final double buttonVerticalOffset = 0.85; // 로그인 버튼 Y축 위치 조정

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/hogwart.png',
              fit: BoxFit.cover,
            ),
          ),
          // Subtitle 이미지 (좌우 가운데, 상하 조정 가능)
          Align(
            alignment: Alignment(0.0, subtitleVerticalOffset), // X축: 0.0(가운데), Y축: 원하는 값
            child: Image.asset(
              'assets/subtitle.png',
              width: 320, // 크기 조정
              height: 160,
            ),
          ),
          // 모리브 포터 이미지 (좌우 가운데, 상하 조정 가능)
          Align(
            alignment: Alignment(0.0, potterVerticalOffset), // X축: 0.0(가운데), Y축: 원하는 값
            child: Image.asset(
              'assets/morib_potter.png',
              width: 240, // 크기 조정
              height: 120,
            ),
          ),
          // 로그인 버튼 (좌우 가운데, 상하 조정 가능)
          Align(
            alignment: Alignment(0.0, buttonVerticalOffset), // X축: 0.0(가운데), Y축: 원하는 값
            child: GestureDetector(
              onTap: () => _loginWithKakao(context),
              child: Image.asset(
                'assets/kakao_login_button.png',
                width: 180, // 버튼 너비
                height: 90, // 버튼 높이
              ),
            ),
          ),
        ],
      ),
    );
  }
}
