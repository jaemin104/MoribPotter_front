import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/survey_page.dart';
import 'screens/assign_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/survey',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(), // 홈 화면
        '/login': (context) => const LoginPage(), // 기존 로그인 화면
        '/survey' : (context) => const SurveyPage(), // 설문조사
        '/assign' : (context) => const AssignPage(), // 기숙사 배정
      },
    );
  }
}
