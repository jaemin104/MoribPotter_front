import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../user_state.dart';

class ExamResultPage extends StatelessWidget {
  final int score;

  const ExamResultPage({Key? key, required this.score}) : super(key: key);

  // 서버와 통신하여 점수를 저장하는 함수
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

  // Grade 계산 함수
  String _calculateGrade(int score) {
    if (score >= 280) {
      return 'A+';
    } else if (score >= 250) {
      return 'A0';
    } else if (score >= 230) {
      return 'B+';
    } else if (score >= 200) {
      return 'B0';
    } else if (score >= 180) {
      return 'C+';
    } else if (score >= 150) {
      return 'C0';
    } else if (score >= 130) {
      return 'D+';
    } else if (score >= 100) {
      return 'D0';
    } else {
      return 'F';
    }
  }

  // Comment 생성 함수
  String _makeComment(int score) {
    if (score >= 280) {
      return '훌륭합니다!\n이 정도면 마법 학교 수석 졸업도 가능하겠군요.\n하지만 자만하지 마세요!';
    } else if (score >= 250) {
      return '좋습니다!\n하지만 아쉽게도 완벽한 점수는 아니네요.\n끝까지 집중하세요.';
    } else if (score >= 230) {
      return '제법입니다!\n하지만 이 정도로 만족한다면 \n더 높은 곳으로 갈 수 없습니다.';
    } else if (score >= 200) {
      return '그럭저럭 하긴 했지만,\n아직 갈 길이 멉니다.\n더 열심히 하세요!';
    } else if (score >= 180) {
      return '분발하세요!\n지금 성적으로는 마법 약재 창고나\n정리하는 일이 전부일 겁니다.';
    } else if (score >= 150) {
      return '이 결과로는\n마법사 면허도 받기 어렵습니다.\n복습하고 더 노력하세요.';
    } else if (score >= 130) {
      return '이게 결과라고요?\n하루 10시간씩 공부하세요!';
    } else {
      return '합격은 커녕\n기본조차 이해하지 못한 상태입니다.\n다시 시작하세요!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final nickname = Provider.of<UserState>(context, listen: false).nickname;

    // 화면 로드 후 점수 저장 API 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (nickname != null) {
        saveScore(nickname, score);
      } else {
        print('닉네임이 설정되지 않았습니다.');
      }
    });

    final grade = _calculateGrade(score);
    final comment = _makeComment(score);

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 설정
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.webp"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 시험 결과 이미지 배치
          Center(
            child: Image.asset(
              'assets/exam_result.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
          // 시험 결과 텍스트
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Text(
                  '마법 포션 시험 결과',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Text(
                  '$score/300점',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '$grade',
                  style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  '$comment',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  '담당교수 류네이프',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          // 버튼: 다른 화면으로 돌아가기
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
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
