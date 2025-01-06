import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'exam_result_page.dart';

class RealExamPage extends StatefulWidget {
  const RealExamPage({Key? key}) : super(key: key);

  @override
  _RealExamPageState createState() => _RealExamPageState();
}

class _RealExamPageState extends State<RealExamPage> {
  Timer? _timer;
  int _remainingTime = 0;
  String _currentQuestion = '';
  int _clickCount = 0;

  final List<String> _examQuestions = [
    '1분 안에\n아라니아 액서메이 포션,\n아라니아 액서메이 포션,\n아라니아 액서메이 포션을\n만드시오.',
    '2분 안에\n아라니아 액서메이 포션,\n아라니아 액서메이 포션,\n아라니아 액서메이 포션을\n만드시오.',
    '3분 안에\n아라니아 액서메이 포션,\n아라니아 액서메이 포션,\n아라니아 액서메이 포션을\n만드시오.',
  ];

  final List<Map<String, dynamic>> _potionIngredeints = [
    {
      'top': 350.0,
      'left': 55.0,
      'ingredient': '다이아몬드',
      'image': 'assets/ingredients/diamond.png',
    },
    {
      'top': 350.0,
      'left': 137.0,
      'ingredient': '천사의 날개',
      'image': 'assets/ingredients/angel_wing.png',
    },
    {
      'top': 345.0,
      'left': 220.0,
      'ingredient': '드래곤의 알',
      'image': 'assets/ingredients/dragon_egg.png',
    },
    {
      'top': 350.0,
      'left': 305.0,
      'ingredient': '드래곤의 피',
      'image': 'assets/ingredients/dragon_blood.jpeg',
    },
    {
      'top': 345.0,
      'left': 385.0,
      'ingredient': '에메랄드',
      'image': 'assets/ingredients/emerald.png',
    },
    {
      'top': 480.0,
      'left': 55.0,
      'ingredient': '기린의 목뼈',
      'image': 'assets/ingredients/giraffe_bone.png',
    },
    {
      'top': 480.0,
      'left': 137.0,
      'ingredient': '기린의 혀',
      'image': 'assets/ingredients/giraffe_tongue.png',
    },
    {
      'top': 480.0,
      'left': 220.0,
      'ingredient': '약초',
      'image': 'assets/ingredients/herb.png',
    },
    {
      'top': 470.0,
      'left': 303.0,
      'ingredient': '마법의 물',
      'image': 'assets/ingredients/magic_water.png',
    },
    {
      'top': 480.0,
      'left': 385.0,
      'ingredient': '루비',
      'image': 'assets/ingredients/ruby.png',
    },
    {
      'top': 620.0,
      'left': 55.0,
      'ingredient': '드래곤의 뿔',
      'image': 'assets/ingredients/dragon_horn.png',
    },
    {
      'top': 620.0,
      'left': 137.0,
      'ingredient': '달팽이 진액',
      'image': 'assets/ingredients/snail_essence.png',
    },
    {
      'top': 625.0,
      'left': 215.0,
      'ingredient': '뱀 껍질',
      'image': 'assets/ingredients/snake_skin.jpeg',
    },
    {
      'top': 620.0,
      'left': 303.0,
      'ingredient': '뱀의 혀',
      'image': 'assets/ingredients/snake_tongue.png',
    },
    {
      'top': 620.0,
      'left': 385.0,
      'ingredient': '거미 다리',
      'image': 'assets/ingredients/spider_leg.png',
    },
  ];

  // 버튼 텍스트 목록
  final List<String> _buttonTexts = [
    '첫 번째 포션\n   제출하기',
    '두 번째 포션\n   제출하기',
    '세 번째 포션\n   제출하기',
  ];

  @override
  void initState() {
    super.initState();
    _selectRandomQuestion();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCustomDialog();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _selectRandomQuestion() {
    final random = Random();
    final randomQuestion =
        _examQuestions[random.nextInt(_examQuestions.length)];

    final timeMatch = RegExp(r'(\d+)분').firstMatch(randomQuestion);
    if (timeMatch != null) {
      final timeInMinutes = int.parse(timeMatch.group(1)!);
      setState(() {
        _currentQuestion = randomQuestion;
        _remainingTime = timeInMinutes * 60;
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 500,
            height: 250,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/exam_problem_background.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                Text(
                  _currentQuestion,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                //const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _startTimer();
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'CustomFont'),
                  ),
                ),
                //const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/potion_shelf5.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // DragTarget (냄비)
          Align(
            alignment: Alignment.bottomCenter,
            child: DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return Image.asset(
                  'assets/potion_pot.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                );
              },
              onAccept: (data) {
                // 현재 표시 중인 스낵바 닫기
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                // 새로운 스낵바 표시
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$data 추가됨!'),
                    duration: const Duration(seconds: 1), // 스낵바 표시 시간 조정
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 100, // 원하는 Y 위치 (위에서 400픽셀)
            left: 160, // 원하는 X 위치 (왼쪽에서 100픽셀)
            child: ElevatedButton(
              onPressed: () {
                if (_clickCount < 2) {
                  setState(() {
                    _clickCount++;
                  });
                } else {
                  // 세 번째 클릭 시 페이지 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExamResultPage(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // 버튼 크기 조정
                backgroundColor: Colors.black.withOpacity(0.7),
              ),
              child: Text(
                _buttonTexts[_clickCount], // 클릭 횟수에 따라 텍스트 변경
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                  fontFamily: 'CustomFont',
                ),
              ),
            ),
          ),
          // Draggable 아이콘 배치
          ..._potionIngredeints.map((ingredient) {
            return Positioned(
              top: ingredient['top'],
              left: ingredient['left'],
              child: GestureDetector(
                onTap: () {
                  showIngredientDialog(
                    context,
                    ingredient['top'],
                    ingredient['left'],
                    ingredient['ingredient'],
                  );
                },
                child: Draggable<String>(
                  data: ingredient['ingredient'],
                  feedback: Material(
                    color: Colors.transparent,
                    child: Image.asset(
                      ingredient['image'],
                      width: 50,
                      height: 50,
                    ),
                  ),
                  childWhenDragging: const SizedBox.shrink(),
                  child: Image.asset(
                    ingredient['image'],
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            );
          }).toList(),
          // AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      _showCustomDialog();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '문제 보기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
          Align(
            alignment: Alignment.topCenter, // 화면 가운데 정렬
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0), // 위에서 80 픽셀 추가
              child: Text(
                '${_remainingTime ~/ 60}분 ${_remainingTime % 60}초',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
