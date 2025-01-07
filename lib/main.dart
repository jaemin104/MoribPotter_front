import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart'; // Provider 사용
import 'user_state.dart'; // 전역 상태 클래스
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/logout_page.dart';
import 'screens/test_page.dart';
import 'screens/survey_page.dart';
import 'screens/assign_page.dart';
import 'screens/self_study_page.dart' as self_study;
import 'screens/textbook_page.dart';
import 'screens/potion_exam_page.dart' as potion_exam;
import 'screens/real_exam_page.dart';
import 'screens/leaderboard_page.dart';
import 'screens/exam_result_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: 'baeb548ff44bc37776394a30c70bd72a');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState()), // UserState 등록
      ],
      child: const MyApp(),
    ),
  );
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
        '/login': (context) => const LoginPage(), // 로그인 화면
        '/logout': (context) => const LogoutPage(), // 로그아웃 화면
        '/test': (context) => const TestPage(),
        '/survey': (context) => const SurveyPage(), // 설문조사 화면
        '/assign': (context) => const AssignPage(), // 기숙사 배정 화면
        '/selfStudy': (context) => const self_study.SelfStudyPage(), // 자습실
        '/textbookPage': (context) => const TextbookPage(),
        '/potionExam': (context) => const potion_exam.PotionExamPage(), // 시험장
        '/realExamPage': (context) => const RealExamPage(),
        '/leaderboard': (context) => const LeaderboardPage(),
        // '/examResultPage': (context) => const ExamResultPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/examResultPage') {
          final args = settings.arguments as int; // 전달받은 점수
          return MaterialPageRoute(
            builder: (context) => ExamResultPage(score: args),
          );
        }
        // 예외 처리: 정의되지 않은 라우트
        // return MaterialPageRoute(
        //   builder: (context) => const RealExamPage(),
        // );
      },
    );
  }
}
