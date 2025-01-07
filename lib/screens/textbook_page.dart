import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TextbookPage extends StatefulWidget {
  const TextbookPage({Key? key}) : super(key: key);

  @override
  _TextbookPageState createState() => _TextbookPageState();
}

class _TextbookPageState extends State<TextbookPage> {
  List<Map<String, dynamic>> pages = [];
  int _currentPage = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPages(); // API에서 데이터 가져오기
  }

  Future<void> fetchPages() async {
    try {
      final response = await http.get(Uri.parse('http://172.10.7.89/recipes'));
      print('API 호출 상태 코드: ${response.statusCode}');
      print('API 응답 데이터: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // 데이터를 두 개씩 묶어서 pages 리스트 생성
        List<Map<String, dynamic>> groupedPages = [];
        for (int i = 0; i < data.length; i += 2) {
          groupedPages.add({
            'leftPage': data[i],
            'rightPage': i + 1 < data.length ? data[i + 1] : null,
          });
        }

        setState(() {
          pages = groupedPages;
          isLoading = false;
        });
      } else {
        print('API 호출 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recipes: $e');
    }
  }

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  void _showRecipe(String title, List<Map<String, dynamic>> ingredients, int fullTime) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/recipe_background.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.fromLTRB(35.0, 45.0, 35.0, 35.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$title 레시피',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'CustomFont', // 커스텀 폰트 사용
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                ...ingredients.map(
                      (ingredient) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ingredient['image']!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            ingredient['text']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'CustomFont', // 커스텀 폰트 사용
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '총 ${fullTime}초 가열하여 완성!', // full_time 표시
                  style: const TextStyle(
                    fontFamily: 'CustomFont', // 커스텀 폰트 사용
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.8), // 배경색: 반투명 검정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // 둥근 모서리
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업 닫기
                  },
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                      fontFamily: 'CustomFont', // 커스텀 폰트
                      color: Colors.white, // 텍스트 색상 흰색
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
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final currentData = pages[_currentPage];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.webp"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/textbook3.png",
                  fit: BoxFit.cover,
                ),
                if (_currentPage > 0)
                  Positioned(
                    bottom: 30,
                    left: 40,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30),
                      color: Colors.black,
                      onPressed: _previousPage,
                    ),
                  ),
                if (_currentPage < pages.length - 1)
                  Positioned(
                    bottom: 30,
                    right: 40,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward, size: 30),
                      color: Colors.black,
                      onPressed: _nextPage,
                    ),
                  ),
              ],
            ),
          ),
          Positioned.fill(
            child: Stack(
              children: [
                // 왼쪽 포션
                Align(
                  alignment: Alignment.centerLeft, // 왼쪽 가운데 정렬
                  child: Padding(
                    padding: const EdgeInsets.only(left: 70.0), // 왼쪽 간격 조정
                    child: GestureDetector(
                      onTap: () {
                        if (currentData['leftPage'] != null) {
                          _showRecipe(
                            currentData['leftPage']['portion_name'],
                            (currentData['leftPage']['ingredients'] as List)
                                .map<Map<String, String>>((ingredient) => {
                              'text':
                              '${ingredient['time']}초 뒤에\n${ingredient['name']} 넣기',
                              'image': ingredient['image'],
                            })
                                .toList(),
                            currentData['leftPage']['full_time'], // full_time 추가
                          );
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // 내용물 크기에 맞춰 Column 크기 설정
                        children: [
                          Text(
                            currentData['leftPage']['portion_name'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'CustomFont',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            currentData['leftPage']['recipe_image'],
                            fit: BoxFit.fitWidth,
                            height: 130,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                // 오른쪽 포션
                Align(
                  alignment: Alignment.centerRight, // 오른쪽 가운데 정렬
                  child: Padding(
                    padding: const EdgeInsets.only(right: 75.0), // 오른쪽 간격 조정
                    child: currentData['rightPage'] != null
                        ? GestureDetector(
                      onTap: () {
                        if (currentData['rightPage'] != null) {
                          _showRecipe(
                            currentData['rightPage']['portion_name'],
                            (currentData['rightPage']['ingredients'] as List)
                                .map<Map<String, String>>((ingredient) => {
                              'text':
                              '${ingredient['time']}초 뒤에\n${ingredient['name']} 넣기',
                              'image': ingredient['image'],
                            })
                                .toList(),
                            currentData['rightPage']['full_time'], // full_time 추가
                          );
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // 내용물 크기에 맞춰 Column 크기 설정
                        children: [
                          Text(
                            currentData['rightPage']['portion_name'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'CustomFont',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            currentData['rightPage']['recipe_image'],
                            fit: BoxFit.cover,
                            height: 130,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '레시피를 보려면\n포션을 클릭하세요',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'CustomFont', // 커스텀 폰트 적용
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
