import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'exam_result_page.dart';
import 'dart:math';

class RealExamPage extends StatefulWidget {
  const RealExamPage({Key? key}) : super(key: key);

  @override
  _RealExamPageState createState() => _RealExamPageState();
}

class _RealExamPageState extends State<RealExamPage> {
  Timer? _timer;
  int _elapsedTime = 0;
  int _currentPotionIndex = 0;
  int _totalScore = 0;
  late String _currentPotion;
  late List<String> _examQuestions;
  int _currentButtonIndex = 0;

  final List<String> _allPotions = [
    '용기의 비약',
    '평온의 비약',
    '사랑의 비약',
    '야망의 비약',
    '치유의 비약',
    '행운의 비약',
  ];

  final Map<String, List<Map<String, dynamic>>> potionAnswers = {
    '용기의 비약': [
      {'ingredient': '마법의 물', 'time': 5},
      {'ingredient': '기린의 혀', 'time': 8},
      {'ingredient': '약초', 'time': 18},
      {'totaltime': '20'}
    ],
    '평온의 비약': [
      {'ingredient': '뱀 껍질', 'time': 7},
      {'ingredient': '다이아몬드', 'time': 11},
      {'ingredient': '드래곤의 피', 'time': 17},
      {'totaltime': '20'}
    ],
    '사랑의 비약': [
      {'ingredient': '뱀의 혀', 'time': 3},
      {'ingredient': '루비', 'time': 7},
      {'ingredient': '마법의 물', 'time': 11},
      {'totaltime': '20'}
    ],
    '야망의 비약': [
      {'ingredient': '거미 다리', 'time': 6},
      {'ingredient': '약초', 'time': 14},
      {'ingredient': '드래곤의 뿔', 'time': 22},
      {'totaltime': '30'}
    ],
    '치유의 비약': [
      {'ingredient': '달팽이 진액', 'time': 5},
      {'ingredient': '드래곤의 알', 'time': 15},
      {'ingredient': '에메랄드', 'time': 19},
      {'totaltime': '30'}
    ],
    '행운의 비약': [
      {'ingredient': '기린의 목뼈', 'time': 4},
      {'ingredient': '천사의 날개', 'time': 10},
      {'ingredient': '다이아몬드', 'time': 19},
      {'totaltime': '30'}
    ],
  };

  final Map<String, dynamic> userInputs = {
    'first': null,
    'first_time': null,
    'second': null,
    'second_time': null,
    'third': null,
    'third_time': null,
  };

  final List<Map<String, String>> _potionIngredients = [
    {'ingredient': '다이아몬드', 'image': 'assets/ingredients/diamond.png'},
    {'ingredient': '천사의 날개', 'image': 'assets/ingredients/angel_wing.png'},
    {'ingredient': '드래곤의 알', 'image': 'assets/ingredients/dragon_egg.png'},
    {'ingredient': '드래곤의 피', 'image': 'assets/ingredients/dragon_blood.png'},
    {'ingredient': '에메랄드', 'image': 'assets/ingredients/emerald.png'},
    {'ingredient': '기린의 목뼈', 'image': 'assets/ingredients/giraffe_bone.png'},
    {'ingredient': '기린의 혀', 'image': 'assets/ingredients/giraffe_tongue.png'},
    {'ingredient': '약초', 'image': 'assets/ingredients/herb.png'},
    {'ingredient': '마법의 물', 'image': 'assets/ingredients/magic_water.png'},
    {'ingredient': '루비', 'image': 'assets/ingredients/ruby.png'},
    {'ingredient': '드래곤의 뿔', 'image': 'assets/ingredients/dragon_horn.png'},
    {'ingredient': '달팽이 진액', 'image': 'assets/ingredients/snail_essence.png'},
    {'ingredient': '뱀 껍질', 'image': 'assets/ingredients/snake_skin.png'},
    {'ingredient': '뱀의 혀', 'image': 'assets/ingredients/snake_tongue.png'},
    {'ingredient': '거미 다리', 'image': 'assets/ingredients/spider_leg.png'},
  ];

  final List<Map<String, double>> _positions = [
    {'top': 280.0, 'left': 50.0}, //첫번째줄
    {'top': 280.0, 'left': 118.0},
    {'top': 280.0, 'left': 187.0},
    {'top': 280.0, 'left': 257.0},
    {'top': 280.0, 'left': 323.0},
    {'top': 393.0, 'left': 50.0}, //두번째줄
    {'top': 393.0, 'left': 118.0},
    {'top': 393.0, 'left': 187.0},
    {'top': 393.0, 'left': 257.0},
    {'top': 393.0, 'left': 323.0},
    {'top': 510.0, 'left': 50.0}, //세번째줄
    {'top': 510.0, 'left': 115.0},
    {'top': 510.0, 'left': 184.0},
    {'top': 510.0, 'left': 257.0},
    {'top': 510.0, 'left': 323.0},
  ];

  List<Map<String, dynamic>> _randomizedIngredients = [];
  final List<String> _buttonTexts = [
    '첫 번째 포션\n   제출하기',
    '두 번째 포션\n   제출하기',
    '세 번째 포션\n   제출하기',
  ];

  @override
  void initState() {
    super.initState();
    _examQuestions = generateRandomQuestions(_allPotions);
    _currentPotion = _examQuestions[0];
    _randomizeIngredients();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCustomDialog();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _elapsedTime = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  void _resetTimer() {
    _elapsedTime = 0;
    _timer?.cancel();
    _startTimer();
  }

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // 포션 리스트를 파싱하여 원하는 형식으로 변환
        final formattedQuestions = _examQuestions
            .map((potion) => '$potion,')
            .join('\n')
            .replaceFirstMapped(RegExp(r',$'), (match) => '을\n만드시오.');

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
              children: [
                const SizedBox(height: 40),
                Text(
                  '$formattedQuestions',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                //const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (_timer == null || !_timer!.isActive) {
                      _startTimer();
                    }
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black, // 텍스트 색상
                        fontFamily: 'CustomFont'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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

  void _recordIngredient(String ingredient, int time) {
    setState(() {
      if (userInputs['first'] == null) {
        userInputs['first'] = ingredient;
        userInputs['first_time'] = time;
      } else if (userInputs['second'] == null) {
        userInputs['second'] = ingredient;
        userInputs['second_time'] = time;
      } else if (userInputs['third'] == null) {
        userInputs['third'] = ingredient;
        userInputs['third_time'] = time;

        // 점수 계산
        final score = _calculateScore(_currentPotion);
        _totalScore += score;

        if (_currentPotionIndex < 2) {
          _currentPotionIndex++;
          _currentPotion = _examQuestions[_currentPotionIndex];
          userInputs.clear();
        }
        // else {
        //   _timer?.cancel();
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ExamResultPage(score: _totalScore),
        //     ),
        //   );
        // }
      }
    });
  }

  List<String> generateRandomQuestions(List<String> allPotions) {
    final random = Random();
    final selectedPotions = List.of(allPotions)..shuffle(random);
    return selectedPotions.take(3).toList();
  }

  void _randomizeIngredients() {
    final random = Random();
    final shuffledPositions = [..._positions]..shuffle(random);
    final shuffledIngredients = [..._potionIngredients]..shuffle(random);

    setState(() {
      _randomizedIngredients = List.generate(15, (index) {
        return {
          ...shuffledIngredients[index],
          ...shuffledPositions[index],
        };
      });
    });
  }

  int _calculateScore(String potionName) {
    int score = 100;
    final answers = potionAnswers[potionName];
    if (answers == null) return score;

    // 로그 찍기
    debugPrint('====== 포션 점수 계산 시작 ======');
    debugPrint('포션 이름: $potionName');

    for (int i = 0; i < 3; i++) {
      final ingredient = userInputs['${['first', 'second', 'third'][i]}'];
      final time =
          userInputs['${['first_time', 'second_time', 'third_time'][i]}'];

      if (ingredient == answers[i]['ingredient']) {
        score -= pow((time - answers[i]['time']).abs(), 2).toInt();
      } else {
        score -= 50;
      }
    }

    // totaltime 비교하여 추가 점수 계산
    final totalTime = int.tryParse(answers.last['totaltime'] ?? '0');
    if (totalTime != null && (totalTime - _elapsedTime).abs() <= 2) {
      score += 7; // totaltime 정확도에 따라 추가 점수
      debugPrint('totaltime 정확도: 성공, +5점');
    } else {
      debugPrint('totaltime 정확도: 실패');
    }

    if (score < 0) {
      score = 0;
    }

    debugPrint('포션 점수: $score');
    debugPrint('==========================');
    return score;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/potion_shelf5.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 32, // 화면 상단에서 16픽셀 아래
            right: 8, // 화면 오른쪽에서 16픽셀 왼쪽
            child: TextButton(
              onPressed: _showCustomDialog, // 다이얼로그 표시
              child: const Text(
                '시험 문제',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // 버튼 텍스트 색상
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                ),
              ),
            ),
          ),
          Positioned(
            top: 80, // 화면 위에서 30 떨어짐
            left: 0,
            right: 0,
            child: Text(
              '${_elapsedTime ~/ 60}분 ${_elapsedTime % 60}초',
              textAlign: TextAlign.center, // 가운데 정렬
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'CustomFont'),
            ),
          ),
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
                // 기존 스낵바를 즉시 닫음
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                // 새 스낵바 표시
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$data 추가됨!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white, // 텍스트 색상
                          fontWeight: FontWeight.bold, // 텍스트 굵기 (선택 사항)
                          fontSize: 12,
                          fontFamily: 'CustomFont'),
                    ),
                    backgroundColor: Colors.black.withOpacity(0.5), // 스낵바 배경색
                    duration: const Duration(seconds: 2), // 스낵바 표시 시간
                  ),
                );

                // 재료 추가 로직
                _recordIngredient(data, _elapsedTime);
              },
            ),
          ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20), // 버튼 위치 조정
                child: TextButton(
                  onPressed: () {
                    if (_currentButtonIndex < 2) {
                      setState(() {
                        _currentButtonIndex++;
                        _randomizeIngredients();
                        _resetTimer();
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExamResultPage(score: _totalScore),
                        ),
                      );
                    }
                    // else if (userInputs['third'] != null) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           ExamResultPage(score: _totalScore),
                    //     ),
                    //   );
                    // }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8), // 최소 패딩
                    backgroundColor: Colors.transparent, // 버튼 배경색
                    foregroundColor: Colors.deepPurpleAccent, // 텍스트 색상
                    textStyle: const TextStyle(
                        fontSize: 18, // 폰트 크기
                        fontWeight: FontWeight.bold, // 폰트 굵기
                        fontFamily: 'CustomFont', // 커스텀 폰트
                        color: Colors.deepPurpleAccent),
                  ),
                  child: Text(
                    _buttonTexts[_currentButtonIndex],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          ..._randomizedIngredients.map((ingredient) {
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
        ],
      ),
    );
  }
}
