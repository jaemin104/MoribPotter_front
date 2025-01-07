// // import 'dart:async';
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'exam_result_page.dart';
// //
// // class RealExamPage extends StatefulWidget {
// //   const RealExamPage({Key? key}) : super(key: key);
// //
// //   @override
// //   _RealExamPageState createState() => _RealExamPageState();
// // }
// //
// // class _RealExamPageState extends State<RealExamPage> {
// //   Timer? _timer;
// //   int _elapsedTime = 0;
// //   int _currentPotionIndex = 0;
// //   int _totalScore = 0;
// //   late String _currentPotion;
// //   late List<String> _examQuestions;
// //   int _currentButtonIndex = 0;
// //
// //   final List<String> _allPotions = [
// //     '용기의 비약',
// //     '평온의 비약',
// //     '사랑의 비약',
// //     '야망의 비약',
// //     '치유의 비약',
// //     '행운의 비약',
// //   ];
// //
// //   final Map<String, List<Map<String, dynamic>>> potionAnswers = {
// //     '용기의 비약': [
// //       {'ingredient': '마법의 물', 'time': 5},
// //       {'ingredient': '기린의 혀', 'time': 8},
// //       {'ingredient': '약초', 'time': 18},
// //     ],
// //     '평온의 비약': [
// //       {'ingredient': '뱀 껍질', 'time': 7},
// //       {'ingredient': '다이아몬드', 'time': 11},
// //       {'ingredient': '드래곤의 피', 'time': 17},
// //     ],
// //     '사랑의 비약': [
// //       {'ingredient': '뱀의 혀', 'time': 3},
// //       {'ingredient': '루비', 'time': 7},
// //       {'ingredient': '마법의 물', 'time': 11},
// //     ],
// //     '야망의 비약': [
// //       {'ingredient': '거미 다리', 'time': 6},
// //       {'ingredient': '약초', 'time': 14},
// //       {'ingredient': '드래곤의 뿔', 'time': 22},
// //     ],
// //     '치유의 비약': [
// //       {'ingredient': '달팽이 진액', 'time': 5},
// //       {'ingredient': '드래곤의 알', 'time': 15},
// //       {'ingredient': '에메랄드', 'time': 19},
// //     ],
// //     '행운의 비약': [
// //       {'ingredient': '기린의 목뼈', 'time': 4},
// //       {'ingredient': '천사의 날개', 'time': 10},
// //       {'ingredient': '다이아몬드', 'time': 19},
// //     ],
// //   };
// //
// //   final Map<String, dynamic> userInputs = {
// //     'first': null,
// //     'first_time': null,
// //     'second': null,
// //     'second_time': null,
// //     'third': null,
// //     'third_time': null,
// //   };
// //
// //   final List<Map<String, String>> _potionIngredients = [
// //     {'ingredient': '다이아몬드', 'image': 'assets/ingredients/diamond.png'},
// //     {'ingredient': '천사의 날개', 'image': 'assets/ingredients/angel_wing.png'},
// //     {'ingredient': '드래곤의 알', 'image': 'assets/ingredients/dragon_egg.png'},
// //     {'ingredient': '드래곤의 피', 'image': 'assets/ingredients/dragon_blood.png'},
// //     {'ingredient': '에메랄드', 'image': 'assets/ingredients/emerald.png'},
// //     {'ingredient': '기린의 목뼈', 'image': 'assets/ingredients/giraffe_bone.png'},
// //     {'ingredient': '기린의 혀', 'image': 'assets/ingredients/giraffe_tongue.png'},
// //     {'ingredient': '약초', 'image': 'assets/ingredients/herb.png'},
// //     {'ingredient': '마법의 물', 'image': 'assets/ingredients/magic_water.png'},
// //     {'ingredient': '루비', 'image': 'assets/ingredients/ruby.png'},
// //     {'ingredient': '드래곤의 뿔', 'image': 'assets/ingredients/dragon_horn.png'},
// //     {'ingredient': '달팽이 진액', 'image': 'assets/ingredients/snail_essence.png'},
// //     {'ingredient': '뱀 껍질', 'image': 'assets/ingredients/snake_skin.png'},
// //     {'ingredient': '뱀의 혀', 'image': 'assets/ingredients/snake_tongue.png'},
// //     {'ingredient': '거미 다리', 'image': 'assets/ingredients/spider_leg.png'},
// //   ];
// //
// //   final List<Map<String, double>> _positions = [
// //     {'top': 350.0, 'left': 55.0},
// //     {'top': 350.0, 'left': 137.0},
// //     {'top': 345.0, 'left': 220.0},
// //     {'top': 350.0, 'left': 305.0},
// //     {'top': 345.0, 'left': 385.0},
// //     {'top': 480.0, 'left': 55.0},
// //     {'top': 480.0, 'left': 137.0},
// //     {'top': 480.0, 'left': 220.0},
// //     {'top': 470.0, 'left': 303.0},
// //     {'top': 480.0, 'left': 385.0},
// //     {'top': 620.0, 'left': 55.0},
// //     {'top': 620.0, 'left': 137.0},
// //     {'top': 625.0, 'left': 215.0},
// //     {'top': 620.0, 'left': 303.0},
// //     {'top': 620.0, 'left': 385.0},
// //   ];
// //
// //   List<Map<String, dynamic>> _randomizedIngredients = [];
// //   final List<String> _buttonTexts = [
// //     '첫 번째 포션\n   제출하기',
// //     '두 번째 포션\n   제출하기',
// //     '세 번째 포션\n   제출하기',
// //   ];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _examQuestions = generateRandomQuestions(_allPotions);
// //     _currentPotion = _examQuestions[0];
// //     _randomizeIngredients();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _showCustomDialog();
// //     });
// //   }
// //
// //   void _startTimer() {
// //     _timer?.cancel();
// //     _elapsedTime = 0;
// //     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
// //       setState(() {
// //         _elapsedTime++;
// //       });
// //     });
// //   }
// //
// //   void _resetTimer() {
// //     _elapsedTime = 0;
// //     _timer?.cancel();
// //     _startTimer();
// //   }
// //
// //   void _showCustomDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return Dialog(
// //           backgroundColor: Colors.transparent,
// //           child: Container(
// //             width: 500,
// //             height: 250,
// //             padding: const EdgeInsets.all(20),
// //             decoration: BoxDecoration(
// //               image: const DecorationImage(
// //                 image: AssetImage("assets/exam_problem_background.png"),
// //                 fit: BoxFit.cover,
// //               ),
// //               borderRadius: BorderRadius.circular(15),
// //             ),
// //             child: Column(
// //               children: [
// //                 const SizedBox(height: 30),
// //                 Text(
// //                   '현재 문제: $_examQuestions',
// //                   style: const TextStyle(
// //                       fontSize: 18, fontWeight: FontWeight.bold),
// //                   textAlign: TextAlign.center,
// //                 ),
// //                 const SizedBox(height: 20),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.pop(context);
// //                     if (_timer == null || !_timer!.isActive) {
// //                       _startTimer();
// //                     }
// //                   },
// //                   child: const Text('닫기'),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   void showIngredientDialog(
// //       BuildContext context, double top, double left, String ingredient) {
// //     showGeneralDialog(
// //       context: context,
// //       barrierDismissible: true,
// //       barrierLabel: '닫기',
// //       barrierColor: Colors.black54, // 다이얼로그 배경 어둡게
// //       transitionDuration: const Duration(milliseconds: 300),
// //       pageBuilder: (context, animation1, animation2) {
// //         return Stack(
// //           children: [
// //             Positioned(
// //               top: top,
// //               left: left,
// //               child: Material(
// //                 color: Colors.transparent,
// //                 child: Container(
// //                   padding: const EdgeInsets.all(8),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(8),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black26,
// //                         blurRadius: 4,
// //                         spreadRadius: 1,
// //                       ),
// //                     ],
// //                   ),
// //                   child: Text(
// //                     ingredient,
// //                     style: const TextStyle(
// //                       fontSize: 14,
// //                       fontFamily: 'CustomFont',
// //                       color: Colors.black,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   void _recordIngredient(String ingredient, int time) {
// //     setState(() {
// //       if (userInputs['first'] == null) {
// //         userInputs['first'] = ingredient;
// //         userInputs['first_time'] = time;
// //       } else if (userInputs['second'] == null) {
// //         userInputs['second'] = ingredient;
// //         userInputs['second_time'] = time;
// //       } else if (userInputs['third'] == null) {
// //         userInputs['third'] = ingredient;
// //         userInputs['third_time'] = time;
// //
// //         final score = _calculateScore(_currentPotion);
// //         _totalScore += score;
// //
// //         if (_currentPotionIndex < 2) {
// //           _currentPotionIndex++;
// //           _currentPotion = _examQuestions[_currentPotionIndex];
// //           userInputs.clear();
// //           _randomizeIngredients();
// //           _resetTimer();
// //         } else {
// //           _timer?.cancel();
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => ExamResultPage(score: _totalScore),
// //             ),
// //           );
// //         }
// //       }
// //     });
// //   }
// //
// //   List<String> generateRandomQuestions(List<String> allPotions) {
// //     final random = Random();
// //     final selectedPotions = List.of(allPotions)..shuffle(random);
// //     return selectedPotions.take(3).toList();
// //   }
// //
// //   void _randomizeIngredients() {
// //     final random = Random();
// //     final shuffledPositions = [..._positions]..shuffle(random);
// //     final shuffledIngredients = [..._potionIngredients]..shuffle(random);
// //
// //     setState(() {
// //       _randomizedIngredients = List.generate(15, (index) {
// //         return {
// //           ...shuffledIngredients[index],
// //           ...shuffledPositions[index],
// //         };
// //       });
// //     });
// //   }
// //
// //   void _logIngredientResult(String ingredient, int time, int index) {
// //     final answers = potionAnswers[_currentPotion];
// //     if (answers == null || index >= answers.length) {
// //       debugPrint('정답이 없음 또는 인덱스 초과');
// //       return;
// //     }
// //
// //     final correctIngredient = answers[index]['ingredient'];
// //     final correctTime = answers[index]['time'];
// //
// //     final isCorrectIngredient = ingredient == correctIngredient;
// //     final isCorrectTime = (time - correctTime).abs() <= 2;
// //
// //     int score = 0;
// //     if (isCorrectIngredient && isCorrectTime) {
// //       score = 10; // 성공 시 점수
// //     } else {
// //       score = -10; // 실패 시 감점
// //     }
// //     _totalScore += score;
// //
// //     debugPrint('====== 로그 ======');
// //     debugPrint('문제 포션: ${_examQuestions.join(', ')}');
// //     debugPrint('현재 포션 이름: $_currentPotion');
// //     debugPrint('정답 재료 ${index + 1}: $correctIngredient, 드랍한 재료: $ingredient');
// //     debugPrint('성공 여부(재료): $isCorrectIngredient');
// //     debugPrint('정답 시간: ${correctTime}s, 드랍한 시간: ${time}s');
// //     debugPrint('성공 여부(시간): $isCorrectTime');
// //     debugPrint('재료 ${index + 1} 점수: $score');
// //     debugPrint('현재까지 총 점수: $_totalScore');
// //     debugPrint('-----------------');
// //   }
// //
// //   int _calculateScore(String potionName) {
// //     int score = 0;
// //     final answers = potionAnswers[potionName];
// //     if (answers == null) return score;
// //
// //     // 로그 찍기
// //     debugPrint('====== 포션 점수 계산 시작 ======');
// //     debugPrint('포션 이름: $potionName');
// //
// //     for (int i = 0; i < answers.length; i++) {
// //       final ingredient = userInputs['${['first', 'second', 'third'][i]}'];
// //       final time =
// //           userInputs['${['first_time', 'second_time', 'third_time'][i]}'];
// //
// //       if (ingredient == answers[i]['ingredient'] &&
// //           (time - answers[i]['time']).abs() <= 2) {
// //         score += 10; // 성공 시 점수
// //         debugPrint('재료 ${i + 1}: 성공, +10점');
// //       } else {
// //         score -= 10; // 실패 시 감점
// //         debugPrint('재료 ${i + 1}: 실패, -10점');
// //       }
// //     }
// //
// //     debugPrint('포션 점수: $score');
// //     debugPrint('==========================');
// //     return score;
// //   }
// //
// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Potion Exam'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.question_mark),
// //             onPressed: _showCustomDialog,
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: [
// //           Container(
// //             decoration: const BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage("assets/potion_shelf5.jpg"),
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.topCenter,
// //             child: Text(
// //               '${_elapsedTime ~/ 60}분 ${_elapsedTime % 60}초',
// //               style: const TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.white),
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: DragTarget<String>(
// //               builder: (context, candidateData, rejectedData) {
// //                 return Image.asset(
// //                   'assets/potion_pot.png',
// //                   width: 300,
// //                   height: 300,
// //                   fit: BoxFit.cover,
// //                 );
// //               },
// //               onAccept: (data) {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text('$data 추가됨!')),
// //                 );
// //                 _recordIngredient(data, _elapsedTime);
// //               },
// //             ),
// //           ),
// //           Align(
// //             alignment: Alignment.bottomRight,
// //             child: Padding(
// //               padding: const EdgeInsets.all(20),
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   if (_currentButtonIndex < 2) {
// //                     setState(() {
// //                       _currentButtonIndex++;
// //                       _randomizeIngredients();
// //                       _resetTimer();
// //                     });
// //                   } else {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) =>
// //                             ExamResultPage(score: _totalScore),
// //                       ),
// //                     );
// //                   }
// //                 },
// //                 child: Text(
// //                   _buttonTexts[_currentButtonIndex],
// //                   textAlign: TextAlign.center,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           ..._randomizedIngredients.map((ingredient) {
// //             return Positioned(
// //               top: ingredient['top'],
// //               left: ingredient['left'],
// //               child: GestureDetector(
// //                 onTap: () {
// //                   showIngredientDialog(
// //                     context,
// //                     ingredient['top'],
// //                     ingredient['left'],
// //                     ingredient['ingredient'],
// //                   );
// //                 },
// //                 child: Draggable<String>(
// //                   data: ingredient['ingredient'],
// //                   feedback: Material(
// //                     color: Colors.transparent,
// //                     child: Image.asset(
// //                       ingredient['image'],
// //                       width: 50,
// //                       height: 50,
// //                     ),
// //                   ),
// //                   childWhenDragging: const SizedBox.shrink(),
// //                   child: Image.asset(
// //                     ingredient['image'],
// //                     width: 50,
// //                     height: 50,
// //                   ),
// //                 ),
// //               ),
// //             );
// //           }).toList(),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'exam_result_page.dart';
//
// class RealExamPage extends StatefulWidget {
//   const RealExamPage({Key? key}) : super(key: key);
//
//   @override
//   _RealExamPageState createState() => _RealExamPageState();
// }
//
// class _RealExamPageState extends State<RealExamPage> {
//   Timer? _timer;
//   int _elapsedTime = 0;
//   int _currentPotionIndex = 0;
//   int _totalScore = 0;
//   late String _currentPotion;
//   late List<String> _examQuestions;
//   int _currentButtonIndex = 0;
//
//   final List<String> _allPotions = [
//     '용기의 비약',
//     '평온의 비약',
//     '사랑의 비약',
//     '야망의 비약',
//     '치유의 비약',
//     '행운의 비약',
//   ];
//
//   final Map<String, List<Map<String, dynamic>>> potionAnswers = {
//     '용기의 비약': [
//       {'ingredient': '마법의 물', 'time': 5},
//       {'ingredient': '기린의 혀', 'time': 8},
//       {'ingredient': '약초', 'time': 18},
//     ],
//     '평온의 비약': [
//       {'ingredient': '뱀 껍질', 'time': 7},
//       {'ingredient': '다이아몬드', 'time': 11},
//       {'ingredient': '드래곤의 피', 'time': 17},
//     ],
//     '사랑의 비약': [
//       {'ingredient': '뱀의 혀', 'time': 3},
//       {'ingredient': '루비', 'time': 7},
//       {'ingredient': '마법의 물', 'time': 11},
//     ],
//     '야망의 비약': [
//       {'ingredient': '거미 다리', 'time': 6},
//       {'ingredient': '약초', 'time': 14},
//       {'ingredient': '드래곤의 뿔', 'time': 22},
//     ],
//     '치유의 비약': [
//       {'ingredient': '달팽이 진액', 'time': 5},
//       {'ingredient': '드래곤의 알', 'time': 15},
//       {'ingredient': '에메랄드', 'time': 19},
//     ],
//     '행운의 비약': [
//       {'ingredient': '기린의 목뼈', 'time': 4},
//       {'ingredient': '천사의 날개', 'time': 10},
//       {'ingredient': '다이아몬드', 'time': 19},
//     ],
//   };
//
//   final Map<String, dynamic> userInputs = {
//     'first': null,
//     'first_time': null,
//     'second': null,
//     'second_time': null,
//     'third': null,
//     'third_time': null,
//   };
//
//   final List<Map<String, String>> _potionIngredients = [
//     {'ingredient': '다이아몬드', 'image': 'assets/ingredients/diamond.png'},
//     {'ingredient': '천사의 날개', 'image': 'assets/ingredients/angel_wing.png'},
//     {'ingredient': '드래곤의 알', 'image': 'assets/ingredients/dragon_egg.png'},
//     {'ingredient': '드래곤의 피', 'image': 'assets/ingredients/dragon_blood.png'},
//     {'ingredient': '에메랄드', 'image': 'assets/ingredients/emerald.png'},
//     {'ingredient': '기린의 목뼈', 'image': 'assets/ingredients/giraffe_bone.png'},
//     {'ingredient': '기린의 혀', 'image': 'assets/ingredients/giraffe_tongue.png'},
//     {'ingredient': '약초', 'image': 'assets/ingredients/herb.png'},
//     {'ingredient': '마법의 물', 'image': 'assets/ingredients/magic_water.png'},
//     {'ingredient': '루비', 'image': 'assets/ingredients/ruby.png'},
//     {'ingredient': '드래곤의 뿔', 'image': 'assets/ingredients/dragon_horn.png'},
//     {'ingredient': '달팽이 진액', 'image': 'assets/ingredients/snail_essence.png'},
//     {'ingredient': '뱀 껍질', 'image': 'assets/ingredients/snake_skin.png'},
//     {'ingredient': '뱀의 혀', 'image': 'assets/ingredients/snake_tongue.png'},
//     {'ingredient': '거미 다리', 'image': 'assets/ingredients/spider_leg.png'},
//   ];
//
//   final List<Map<String, double>> _positions = [
//     {'top': 350.0, 'left': 55.0},
//     {'top': 350.0, 'left': 137.0},
//     {'top': 345.0, 'left': 220.0},
//     {'top': 350.0, 'left': 305.0},
//     {'top': 345.0, 'left': 385.0},
//     {'top': 480.0, 'left': 55.0},
//     {'top': 480.0, 'left': 137.0},
//     {'top': 480.0, 'left': 220.0},
//     {'top': 470.0, 'left': 303.0},
//     {'top': 480.0, 'left': 385.0},
//     {'top': 620.0, 'left': 55.0},
//     {'top': 620.0, 'left': 137.0},
//     {'top': 625.0, 'left': 215.0},
//     {'top': 620.0, 'left': 303.0},
//     {'top': 620.0, 'left': 385.0},
//   ];
//
//   List<Map<String, dynamic>> _randomizedIngredients = [];
//   final List<String> _buttonTexts = [
//     '첫 번째 포션\n   제출하기',
//     '두 번째 포션\n   제출하기',
//     '세 번째 포션\n   제출하기',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _examQuestions = generateRandomQuestions(_allPotions);
//     _currentPotion = _examQuestions[0];
//     _randomizeIngredients();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _showCustomDialog();
//     });
//   }
//
//   void _startTimer() {
//     _timer?.cancel();
//     _elapsedTime = 0;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         _elapsedTime++;
//       });
//     });
//   }
//
//   void _resetTimer() {
//     _elapsedTime = 0;
//     _timer?.cancel();
//     _startTimer();
//   }
//
//   void _showCustomDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             width: 500,
//             height: 250,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               image: const DecorationImage(
//                 image: AssetImage("assets/exam_problem_background.png"),
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 30),
//                 Text(
//                   '현재 문제: $_examQuestions',
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     if (_timer == null || !_timer!.isActive) {
//                       _startTimer();
//                     }
//                   },
//                   child: const Text('닫기'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void showIngredientDialog(
//       BuildContext context, double top, double left, String ingredient) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: '닫기',
//       barrierColor: Colors.black54, // 다이얼로그 배경 어둡게
//       transitionDuration: const Duration(milliseconds: 300),
//       pageBuilder: (context, animation1, animation2) {
//         return Stack(
//           children: [
//             Positioned(
//               top: top,
//               left: left,
//               child: Material(
//                 color: Colors.transparent,
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 4,
//                         spreadRadius: 1,
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     ingredient,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'CustomFont',
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _recordIngredient(String ingredient, int time) {
//     setState(() {
//       if (userInputs['first'] == null) {
//         userInputs['first'] = ingredient;
//         userInputs['first_time'] = time;
//       } else if (userInputs['second'] == null) {
//         userInputs['second'] = ingredient;
//         userInputs['second_time'] = time;
//       } else if (userInputs['third'] == null) {
//         userInputs['third'] = ingredient;
//         userInputs['third_time'] = time;
//       }
//     });
//   }
//
//   List<String> generateRandomQuestions(List<String> allPotions) {
//     final random = Random();
//     final selectedPotions = List.of(allPotions)..shuffle(random);
//     return selectedPotions.take(3).toList();
//   }
//
//   void _randomizeIngredients() {
//     final random = Random();
//     final shuffledPositions = [..._positions]..shuffle(random);
//     final shuffledIngredients = [..._potionIngredients]..shuffle(random);
//
//     setState(() {
//       _randomizedIngredients = List.generate(15, (index) {
//         return {
//           ...shuffledIngredients[index],
//           ...shuffledPositions[index],
//         };
//       });
//     });
//   }
//
//   // void _logIngredientResult(String ingredient, int time, int index) {
//   //   final answers = potionAnswers[_currentPotion];
//   //   if (answers == null || index >= answers.length) {
//   //     debugPrint('정답이 없음 또는 인덱스 초과');
//   //     return;
//   //   }
//   //
//   //   final correctIngredient = answers[index]['ingredient'];
//   //   final correctTime = answers[index]['time'];
//   //
//   //   final isCorrectIngredient = ingredient == correctIngredient;
//   //   final isCorrectTime = (time - correctTime).abs() <= 2;
//   //
//   //   int score = 0;
//   //   if (isCorrectIngredient && isCorrectTime) {
//   //     score = 10; // 성공 시 점수
//   //   } else {
//   //     score = -10; // 실패 시 감점
//   //   }
//   //   _totalScore += score;
//   //
//   //   debugPrint('====== 로그 ======');
//   //   debugPrint('문제 포션: ${_examQuestions.join(', ')}');
//   //   debugPrint('현재 포션 이름: $_currentPotion');
//   //   debugPrint('정답 재료 ${index + 1}: $correctIngredient, 드랍한 재료: $ingredient');
//   //   debugPrint('성공 여부(재료): $isCorrectIngredient');
//   //   debugPrint('정답 시간: ${correctTime}s, 드랍한 시간: ${time}s');
//   //   debugPrint('성공 여부(시간): $isCorrectTime');
//   //   debugPrint('재료 ${index + 1} 점수: $score');
//   //   debugPrint('현재까지 총 점수: $_totalScore');
//   //   debugPrint('-----------------');
//   // }
//
//   int _calculateScore(String potionName) {
//     int score = 0;
//     final answers = potionAnswers[potionName];
//     if (answers == null) return score;
//
//     // 로그 찍기
//     debugPrint('====== 포션 점수 계산 시작 ======');
//     debugPrint('포션 이름: $potionName');
//
//     for (int i = 0; i < answers.length; i++) {
//       final ingredient = userInputs['${['first', 'second', 'third'][i]}'];
//       final time =
//           userInputs['${['first_time', 'second_time', 'third_time'][i]}'];
//
//       if (ingredient == answers[i]['ingredient'] &&
//           (time - answers[i]['time']).abs() <= 2) {
//         score += 10; // 성공 시 점수
//         debugPrint('재료 ${i + 1}: 성공, +10점');
//       } else {
//         score -= 10; // 실패 시 감점
//         debugPrint('재료 ${i + 1}: 실패, -10점');
//       }
//     }
//
//     debugPrint('포션 점수: $score');
//     debugPrint('==========================');
//     return score;
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Potion Exam'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.question_mark),
//             onPressed: _showCustomDialog,
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/potion_shelf5.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Text(
//               '${_elapsedTime ~/ 60}분 ${_elapsedTime % 60}초',
//               style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: DragTarget<String>(
//               builder: (context, candidateData, rejectedData) {
//                 return Image.asset(
//                   'assets/potion_pot.png',
//                   width: 300,
//                   height: 300,
//                   fit: BoxFit.cover,
//                 );
//               },
//               onAccept: (data) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('$data 추가됨!')),
//                 );
//                 _recordIngredient(data, _elapsedTime);
//               },
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_currentButtonIndex < 2) {
//                     setState(() {
//                       _currentButtonIndex++;
//                       _randomizeIngredients();
//                       _resetTimer();
//                     });
//                   } else {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             ExamResultPage(score: _totalScore),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text(
//                   _buttonTexts[_currentButtonIndex],
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),
//           ..._randomizedIngredients.map((ingredient) {
//             return Positioned(
//               top: ingredient['top'],
//               left: ingredient['left'],
//               child: GestureDetector(
//                 onTap: () {
//                   showIngredientDialog(
//                     context,
//                     ingredient['top'],
//                     ingredient['left'],
//                     ingredient['ingredient'],
//                   );
//                 },
//                 child: Draggable<String>(
//                   data: ingredient['ingredient'],
//                   feedback: Material(
//                     color: Colors.transparent,
//                     child: Image.asset(
//                       ingredient['image'],
//                       width: 50,
//                       height: 50,
//                     ),
//                   ),
//                   childWhenDragging: const SizedBox.shrink(),
//                   child: Image.asset(
//                     ingredient['image'],
//                     width: 50,
//                     height: 50,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }
// }

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
    ],
    '평온의 비약': [
      {'ingredient': '뱀 껍질', 'time': 7},
      {'ingredient': '다이아몬드', 'time': 11},
      {'ingredient': '드래곤의 피', 'time': 17},
    ],
    '사랑의 비약': [
      {'ingredient': '뱀의 혀', 'time': 3},
      {'ingredient': '루비', 'time': 7},
      {'ingredient': '마법의 물', 'time': 11},
    ],
    '야망의 비약': [
      {'ingredient': '거미 다리', 'time': 6},
      {'ingredient': '약초', 'time': 14},
      {'ingredient': '드래곤의 뿔', 'time': 22},
    ],
    '치유의 비약': [
      {'ingredient': '달팽이 진액', 'time': 5},
      {'ingredient': '드래곤의 알', 'time': 15},
      {'ingredient': '에메랄드', 'time': 19},
    ],
    '행운의 비약': [
      {'ingredient': '기린의 목뼈', 'time': 4},
      {'ingredient': '천사의 날개', 'time': 10},
      {'ingredient': '다이아몬드', 'time': 19},
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
                const SizedBox(height: 30),
                Text(
                  '현재 문제: $_examQuestions',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (_timer == null || !_timer!.isActive) {
                      _startTimer();
                    }
                  },
                  child: const Text('닫기'),
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
          _randomizeIngredients();
          _resetTimer();
        } else {
          _timer?.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExamResultPage(score: _totalScore),
            ),
          );
        }
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
    int score = 0;
    final answers = potionAnswers[potionName];
    if (answers == null) return score;

    // 로그 찍기
    debugPrint('====== 포션 점수 계산 시작 ======');
    debugPrint('포션 이름: $potionName');

    for (int i = 0; i < answers.length; i++) {
      final ingredient = userInputs['${['first', 'second', 'third'][i]}'];
      final time =
          userInputs['${['first_time', 'second_time', 'third_time'][i]}'];

      if (ingredient == answers[i]['ingredient'] &&
          (time - answers[i]['time']).abs() <= 2) {
        score += 10; // 성공 시 점수
        debugPrint('재료 ${i + 1}: 성공, +10점');
      } else {
        score -= 10; // 실패 시 감점
        debugPrint('재료 ${i + 1}: 실패, -10점');
      }
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
      appBar: AppBar(
        title: const Text('Potion Exam'),
        actions: [
          IconButton(
            icon: const Icon(Icons.question_mark),
            onPressed: _showCustomDialog,
          ),
        ],
      ),
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
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              '${_elapsedTime ~/ 60}분 ${_elapsedTime % 60}초',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$data 추가됨!')),
                );
                _recordIngredient(data, _elapsedTime);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
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
                },
                child: Text(
                  _buttonTexts[_currentButtonIndex],
                  textAlign: TextAlign.center,
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
