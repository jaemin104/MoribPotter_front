import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RealExamPage extends StatefulWidget {
  const RealExamPage({Key? key}) : super(key: key);

  @override
  _RealExamPageState createState() => _RealExamPageState();
}

class _RealExamPageState extends State<RealExamPage> {
  Timer? _timer; // nullable로 변경하여 초기 상태 관리
  int _remainingTime = 0; // 남은 시간 (초)
  String _currentQuestion = ''; // 현재 문제

  final List<String> _examQuestions = [
    '1분 안에\n무슨 포션,\n무슨 포션,\n무슨 포션을 만드시오.',
    '2분 안에\n무슨 포션,\n무슨 포션,\n무슨 포션을 만드시오.',
    '3분 안에\n무슨 포션,\n무슨 포션,\n무슨 포션을 만드시오.',
    '4분 안에\n무슨 포션,\n무슨 포션,\n무슨 포션을 만드시오.',
    '5분 안에\n무슨 포션,\n무슨 포션,\n무슨 포션을 만드시오.',
  ];

  @override
  void initState() {
    super.initState();
    _selectRandomQuestion(); // 랜덤 문제 선택
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCustomDialog(); // 페이지 로드 후 다이얼로그 표시
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // null 체크 후 타이머 종료
    super.dispose();
  }

  void _selectRandomQuestion() {
    final random = Random();
    final randomQuestion =
        _examQuestions[random.nextInt(_examQuestions.length)];

    // 문제에서 시간을 파싱 (예: "1분 안에" -> 1분)
    final timeMatch = RegExp(r'(\d+)분').firstMatch(randomQuestion);
    if (timeMatch != null) {
      final timeInMinutes = int.parse(timeMatch.group(1)!); // "1"을 정수로 변환
      setState(() {
        _currentQuestion = randomQuestion;
        _remainingTime = timeInMinutes * 60; // 초로 변환
      });
    }
  }

  void _startTimer() {
    _timer?.cancel(); // null 체크 후 기존 타이머 취소
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel(); // 시간이 끝나면 타이머 취소
        // 시간 초과 처리 (필요 시 추가)
      }
    });
  }

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // 다이얼로그 배경 투명
          child: Container(
            width: 500, // 다이얼로그 너비
            height: 250, // 다이얼로그 높이
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                    "assets/exam_problem_background.png"), // 배경 이미지 경로
                fit: BoxFit.cover, // 이미지 채우기
              ),
              borderRadius: BorderRadius.circular(15), // 테두리 둥글게
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '시험 문제',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // 텍스트 색상
                  ),
                ),
                const SizedBox(height: 10), // 텍스트 사이 간격
                Text(
                  _currentQuestion,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black, // 텍스트 색상
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(), // 버튼과 텍스트 사이 간격 늘리기
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                    _startTimer(); // 다이얼로그 닫힌 후 타이머 시작
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // 닫기 버튼 색상
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 약병 아이콘의 위치와 정보를 설정
    final List<Map<String, dynamic>> potionIcons = [
      {'top': 160.0, 'left': 5.0, 'ingredient': '드래곤의 뿔'},
      {'top': 250.0, 'left': 200.0, 'ingredient': '블루 포션 재료'},
      {'top': 300.0, 'left': 300.0, 'ingredient': '그린 포션 재료'},
    ];

    // 다이얼로그를 표시하는 함수
    void showIngredientDialog(
        BuildContext context, double top, double left, String ingredient) {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '닫기',
        barrierColor: Colors.black54, // 다이얼로그 배경 어둡게
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation1, animation2) {
          return Stack(
            children: [
              Positioned(
                top: top,
                left: left,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      ingredient,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'CustomFont',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/potion_shelf2.png"), // 배경 이미지 경로
                fit: BoxFit.cover, // 화면을 채우도록 설정
              ),
            ),
          ),
          ...potionIcons.map((potion) {
            return Positioned(
              top: potion['top'],
              left: potion['left'],
              child: GestureDetector(
                onTap: () {
                  showIngredientDialog(
                    context,
                    potion['top'],
                    potion['left'],
                    potion['ingredient'],
                  ); // 클릭 시 다이얼로그 표시
                },
                child: const Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
          }).toList(),
          // AppBar 커스텀
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent, // AppBar 배경 투명
              elevation: 0, // 그림자 제거
              centerTitle: true, // 타이틀 중앙 정렬
              leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context); // 이전 페이지로 이동
                },
              ),
              title: Text(
                '${_remainingTime ~/ 60}분 ${_remainingTime % 60}초',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CustomFont'),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10), // 오른쪽 여백 추가
                  child: GestureDetector(
                    onTap: () {
                      _showCustomDialog(); // 다이얼로그 열기
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8), // 내부 여백
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7), // 버튼 배경색
                        borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글게
                      ),
                      child: const Text(
                        '문제 보기',
                        style: TextStyle(
                          color: Colors.white, // 텍스트 색상
                          fontSize: 16, // 텍스트 크기
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CustomFont',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 하단 이미지
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/potion_pot2.png',
              width: 300,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
