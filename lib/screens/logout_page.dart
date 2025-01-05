import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LogoutPage extends StatelessWidget {
  final String? nickname;

  const LogoutPage({Key? key, this.nickname}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      await UserApi.instance.unlink(); // 카카오 계정 연결 해제 (선택 사항)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그아웃 및 계정 해제 완료')),
      );
      // 로그아웃 성공 후 로그인 페이지로 이동
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그아웃 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그아웃')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 유저 정보 표시
            if (nickname != null) ...[
              Text('닉네임: $nickname', style: const TextStyle(fontSize: 18)),
            ] else
              const Text('유저 정보를 불러올 수 없습니다.',
                  style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}
