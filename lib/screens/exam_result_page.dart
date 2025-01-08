import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../user_state.dart';

class ExamResultPage extends StatelessWidget {
  final int score;

  const ExamResultPage({Key? key, required this.score}) : super(key: key);

  Future<void> saveScore(String nickname, int score) async {
    try {
      // 닉네임으로 user_id 조회 요청
      final userIdResponse = await http.post(
        Uri.parse('http://172.10.7.89/auth/get_user_id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      if (userIdResponse.statusCode == 200) {
        final userId = jsonDecode(userIdResponse.body)['user_id'];

        // user_id와 score를 서버에 저장 요청
        final saveScoreResponse = await http.post(
          Uri.parse('http://172.10.7.89/scores/save'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'user_id': userId, 'score': score}),
        );

        if (saveScoreResponse.statusCode == 200) {
          print('점수 저장 성공');
        } else {
          print('점수 저장 실패: ${saveScoreResponse.body}');
        }
      } else {
        print('사용자 ID 조회 실패: ${userIdResponse.body}');
      }
    } catch (e) {
      print('점수 저장 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nickname = Provider.of<UserState>(context, listen: false).nickname;

    // 화면 로드 후 API 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (nickname != null) {
        saveScore(nickname, score);
      } else {
        print('닉네임이 설정되지 않았습니다.');
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 (background)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.webp"), // 배경 이미지 경로
                fit: BoxFit.cover, // 화면을 채우도록 설정
              ),
            ),
          ),
          // exam_result 이미지를 배치
          Center(
            child: Image.asset(
              'assets/exam_result.png', // exam_result 이미지 경로
              width: MediaQuery.of(context).size.width, // 가로 길이에 맞게 설정
              fit: BoxFit.contain, // 이미지 비율 유지
            ),
          ),
          // 시험 결과 내용
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30), // exam_result 위로 간격
                // 타이틀
                const Text(
                  '마법 포션 시험 결과',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // 총점
                Text(
                  '총점: $score',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          // 홈으로 돌아가기 버튼 (기존 버튼 유지)
          Positioned(
            bottom: 50, // 화면 아래에서 50픽셀 위에 배치
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home'); // home_page.dart로 이동
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.black.withOpacity(0.7),
                ),
                child: const Text(
                  '기숙사로 돌아가기',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CustomFont',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
