import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // 서버의 Google 로그인 API URL
  final String loginUrl = 'http://143.248.222.21:3000/auth/google';

  // URL 실행 함수
  Future<void> _launchLoginUrl() async {
    if (await canLaunch(loginUrl)) {
      await launch(loginUrl, forceWebView: false, forceSafariVC: false);
    } else {
      throw 'Could not launch $loginUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: _launchLoginUrl,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.login,
                  size: 50,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}