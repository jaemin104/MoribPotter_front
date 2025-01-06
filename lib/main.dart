import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/logout_page.dart';
import 'screens/test_page.dart';
import 'screens/survey_page.dart';
import 'screens/assign_page.dart';
import 'screens/self_study_page.dart' as self_study;
import 'screens/textbook_page.dart';
import 'screens/potion_exam_page.dart' as potion_exam;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: 'baeb548ff44bc37776394a30c70bd72a');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomePage(), // 홈 화면
        '/login': (context) => const LoginPage(), // 기존 로그인 화면
        '/logout': (context) {
          // arguments 수신
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          return LogoutPage(
            nickname: args?['nickname'], // nickname 전달
          );
        },
        '/test' : (context) => const TestPage(),
        '/survey' : (context) => const SurveyPage(), // 설문조사
        '/assign' : (context) => const AssignPage(), // 기숙사 배정
        '/selfStudy': (context) => const self_study.SelfStudyPage(), //자습실
        '/textbookPage': (context) => const TextbookPage(),
        '/potionExam': (context) => const potion_exam.PotionExamPage(), // 시험장
      },
    );
  }
}
