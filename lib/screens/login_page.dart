import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _loginWithKakao(BuildContext context) async {
    try {
      // 기존 세션 초기화
      //await UserApi.instance.logout();
      // 카카오톡 앱이 설치되어 있다면 앱으로 로그인

      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        // 카카오톡 앱이 설치되지 않은 경우, 계정 로그인
        await UserApi.instance.loginWithKakaoAccount();
      }

      // 사용자 정보 가져오기
      User user = await UserApi.instance.me();
      Navigator.pushNamed(context, '/logout', arguments: {
        'nickname': user.kakaoAccount?.profile?.nickname,
      });
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
