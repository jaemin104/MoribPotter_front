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
  int _elapsedTime = 0; // 경과 시간을 저장하는 변수

  String _currentQuestion = '';
  int _clickCount = 0;

  final List<String> _allPotions = [
    '용기의 비약',
    '평온의 비약',
    '사랑의 비약',
    '야망의 비약',
    '치유의 비약',
    '행운의 비약',
  ];
  List<String> generateRandomQuestions(List<String> allPotions) {
    final random = Random();
    final selectedPotions = List.of(allPotions)..shuffle(random);
    final selectedThree = selectedPotions.take(3).toList();

    return [
      '${selectedThree[0]},\n${selectedThree[1]},\n${selectedThree[2]}을\n완벽하게 만드시오.',
    ];
  }

  final List<Map<String, String>> _potionIngredients = [
    {
      'ingredient': '다이아몬드',
      'image': 'assets/ingredients/diamond.png',
    },
    {
      'ingredient': '천사의 날개',
      'image': 'assets/ingredients/angel_wing.png',
    },
    {
      'ingredient': '드래곤의 알',
      'image': 'assets/ingredients/dragon_egg.png',
    },
    {
      'ingredient': '드래곤의 피',
      'image': 'assets/ingredients/dragon_blood.jpeg',
    },
    {
      'ingredient': '에메랄드',
      'image': 'assets/ingredients/emerald.png',
    },
    {
      'ingredient': '기린의 목뼈',
      'image': 'assets/ingredients/giraffe_bone.png',
    },
    {
      'ingredient': '기린의 혀',
      'image': 'assets/ingredients/giraffe_tongue.png',
    },
    {
      'ingredient': '약초',
      'image': 'assets/ingredients/herb.png',
    },
    {
      'ingredient': '마법의 물',
      'image': 'assets/ingredients/magic_water.png',
    },
    {
      'ingredient': '루비',
      'image': 'assets/ingredients/ruby.png',
    },
    {
      'ingredient': '드래곤의 뿔',
      'image': 'assets/ingredients/dragon_horn.png',
    },
    {
      'ingredient': '달팽이 진액',
      'image': 'assets/ingredients/snail_essence.png',
    },
    {
      'ingredient': '뱀 껍질',
      'image': 'assets/ingredients/snake_skin.jpeg',
    },
    {
      'ingredient': '뱀의 혀',
      'image': 'assets/ingredients/snake_tongue.png',
    },
    {
      'ingredient': '거미 다리',
      'image': 'assets/ingredients/spider_leg.png',
    },
  ];

  final List<Map<String, double>> _positions = [
    {'top': 350.0, 'left': 55.0},
    {'top': 350.0, 'left': 137.0},
    {'top': 345.0, 'left': 220.0},
    {'top': 350.0, 'left': 305.0},
    {'top': 345.0, 'left': 385.0},
    {'top': 480.0, 'left': 55.0},
    {'top': 480.0, 'left': 137.0},
    {'top': 480.0, 'left': 220.0},
    {'top': 470.0, 'left': 303.0},
    {'top': 480.0, 'left': 385.0},
    {'top': 620.0, 'left': 55.0},
    {'top': 620.0, 'left': 137.0},
    {'top': 625.0, 'left': 215.0},
    {'top': 620.0, 'left': 303.0},
    {'top': 620.0, 'left': 385.0},
  ];

  List<Map<String, dynamic>> _randomizedIngredients = [];

  // 버튼 텍스트 목록
  final List<String> _buttonTexts = [
    '첫 번째 포션\n   제출하기',
    '두 번째 포션\n   제출하기',
    '세 번째 포션\n   제출하기',
  ];

  late List<String> _examQuestions;

  @override
  void initState() {
    super.initState();
    _examQuestions = generateRandomQuestions(_allPotions);
    _selectRandomQuestion();
    _randomizeIngredients();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCustomDialog();
    });
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _selectRandomQuestion() {
    final random = Random();
    setState(() {
      _currentQuestion = _examQuestions[random.nextInt(_examQuestions.length)];
      _elapsedTime = 0; // 타이머 초기화
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
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
              ],
            ),
          ),
        );
      },
    );
  }

  // 재료 다이얼로그를 표시하는 함수
  void showIngredientDialog(
      BuildContext context, double top, double left, String ingredient) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '닫기',
      barrierColor: Colors.black54,
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
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$data 추가됨!'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 100,
            left: 160,
            child: ElevatedButton(
              onPressed: () {
                if (_clickCount < 2) {
                  setState(() {
                    _clickCount++;
                    _randomizeIngredients(); // 재료 위치를 랜덤으로 변경
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExamResultPage(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.black.withOpacity(0.7),
              ),
              child: Text(
                _buttonTexts[_clickCount],
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
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Text(
                '${_elapsedTime ~/ 60}분 ${_elapsedTime % 60}초',
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
