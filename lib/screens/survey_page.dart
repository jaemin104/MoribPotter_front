import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../user_state.dart'; // 전역 상태 클래스 임포트

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "당신이 가장 자랑스럽게 여기는 \n성격적 강점은 무엇입니까?",
      "choices": [
        {"text": "용기와 결단력", "house": "g_dorm"},
        {"text": "지혜와 창의성", "house": "r_dorm"},
        {"text": "야망과 끈기", "house": "s_dorm"},
        {"text": "성실함과 충성심", "house": "h_dorm"}
      ],
    },
    {
      "question": "팀 프로젝트에서 \n당신은 어떤 역할을 선호합니까?",
      "choices": [
        {"text": "리더가 되어 팀을 이끈다.", "house": "s_dorm"},
        {"text": "팀원들에게 열정과 동기를 불어넣는다.", "house": "g_dorm"},
        {"text": "팀 내의 조화를 유지하고 다른 사람을 돕는다.", "house": "h_dorm"},
        {"text": "창의적이고 효율적인 아이디어를 제안한다.", "house": "r_dorm"}
      ],
    },
    {
      "question": "호그와트의 비밀 통로에서 길을 \n잃었다면 당신은 무엇을 하겠습니까?",
      "choices": [
        {"text": "오히려 좋아! 모험을 즐긴다.", "house": "g_dorm"},
        {"text": "지도와 논리를 사용해 출구를 찾는다.", "house": "r_dorm"},
        {"text": "누군가에게 유리하게 작용할 정보를 수집한다.", "house": "s_dorm"},
        {"text": "동료들과 협력하여 탈출 방법을 찾는다.", "house": "h_dorm"}
      ],
    },
    {
      "question": "마법 세계에서 당신이 가장 먼저 \n배우고 싶은 마법은 무엇입니까?",
      "choices": [
        {"text": "자연을 이해하고 활용하는 마법", "house": "r_dorm"},
        {"text": "나와 다른 사람을 보호하는 방어 마법", "house": "g_dorm"},
        {"text": "사람의 마음을 읽거나 조종하는 마법", "house": "s_dorm"},
        {"text": "음식과 생활을 더 풍요롭게 하는 마법", "house": "h_dorm"}
      ],
    },
  ];

  int currentQuestionIndex = 0;
  Map<String, int> houseScores = {
    "g_dorm": 0,
    "r_dorm": 0,
    "s_dorm": 0,
    "h_dorm": 0,
  };

  void _saveAnswerAndNext(String house) {
    setState(() {
      houseScores[house] = houseScores[house]! + 1;
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _calculateResultAndNavigate();
      }
    });
  }

  Future<void> _calculateResultAndNavigate() async {
    // 최종 점수가 높은 기숙사 계산
    final sortedHouses = houseScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topHouse = sortedHouses.first.key;

    // 전역 상태에 기숙사 정보 저장
    final userState = Provider.of<UserState>(context, listen: false);
    userState.setDorm(topHouse); // setDorm() 메서드 사용

    try {
      // 서버에 기숙사 정보 저장
      final response = await http.post(
        Uri.parse('http://172.10.7.89/auth/save_dorm'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nickname': userState.nickname, // 전역 상태의 닉네임
          'dorm': topHouse,
        }),
      );

      if (response.statusCode == 200) {
        // 성공하면 home_page로 이동
        Navigator.pushReplacementNamed(context, '/assign');
      } else {
        throw Exception('기숙사 저장 실패: ${response.body}');
      }
    } catch (e) {
      // 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('기숙사 저장 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionData = questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.webp"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 설문조사 영역
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 질문 번호
                  Text(
                    "Question ${currentQuestionIndex + 1}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'CustomFont'),
                  ),
                  const SizedBox(height: 20),
                  // 질문 텍스트
                  Text(
                    questionData["question"],
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CustomFont'),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // 선택지 버튼
                  ...List.generate(
                    questionData["choices"].length,
                    (index) {
                      final choice = questionData["choices"][index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.7),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {
                            _saveAnswerAndNext(choice["house"]);
                          },
                          child: Text(
                            choice["text"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'CustomFont',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
