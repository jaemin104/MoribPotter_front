import 'package:flutter/material.dart';

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
        {"text": "용기와 결단력", "house": "gryffindor"},
        {"text": "지혜와 창의성", "house": "ravenclaw"},
        {"text": "야망과 끈기", "house": "slytherin"},
        {"text": "성실함과 충성심", "house": "hufflepuff"}
      ],
    },
    {
      "question": "팀 프로젝트에서 \n당신은 어떤 역할을 선호합니까?",
      "choices": [
        {"text": "리더가 되어 팀을 이끈다.", "house": "slytherin"},
        {"text": "팀원들에게 열정과 동기를 불어넣는다.", "house": "gryffindor"},
        {"text": "팀 내의 조화를 유지하고 다른 사람을 돕는다.", "house": "hufflepuff"},
        {"text": "창의적이고 효율적인 아이디어를 제안한다.", "house": "ravenclaw"}
      ],
    },
    {
      "question": "호그와트의 비밀 통로에서 길을 \n잃었다면 당신은 무엇을 하겠습니까?",
      "choices": [
        {"text": "오히려 좋아! 모험을 즐긴다.", "house": "gryffindor"},
        {"text": "지도와 논리를 사용해 출구를 찾는다.", "house": "ravenclaw"},
        {"text": "누군가에게 유리하게 작용할 정보를 수집한다.", "house": "slytherin"},
        {"text": "동료들과 협력하여 탈출 방법을 찾는다.", "house": "hufflepuff"}
      ],
    },
    {
      "question": "마법 세계에서 당신이 가장 먼저 \n배우고 싶은 마법은 무엇입니까?",
      "choices": [
        {"text": "자연을 이해하고 활용하는 마법", "house": "ravenclaw"},
        {"text": "나와 다른 사람을 보호하는 방어 마법", "house": "gryffindor"},
        {"text": "사람의 마음을 읽거나 조종하는 마법", "house": "slytherin"},
        {"text": "음식과 생활을 더 풍요롭게 하는 마법", "house": "hufflepuff"}
      ],
    },
  ];

  int currentQuestionIndex = 0;
  Map<String, int> houseScores = {
    "gryffindor": 0,
    "ravenclaw": 0,
    "slytherin": 0,
    "hufflepuff": 0,
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

  void _calculateResultAndNavigate() {
    final sortedHouses = houseScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topHouse = sortedHouses.first.key;

    Navigator.pushReplacementNamed(
      context,
      '/assign',
      arguments: topHouse,
    );
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
              margin: const EdgeInsets.all(20), // 배경과의 여백 설정
              padding: const EdgeInsets.all(20), // 내용과의 여백 설정
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), // 반투명 흰색 배경
                borderRadius: BorderRadius.circular(15), // 둥근 모서리
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
                            backgroundColor:
                                Colors.black.withOpacity(0.7), // 버튼 배경색
                            // foregroundColor: Colors.deepPurpleAccent, // 텍스트 색상
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
