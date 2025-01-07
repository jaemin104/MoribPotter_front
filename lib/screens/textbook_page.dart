import 'package:flutter/material.dart';

class TextbookPage extends StatefulWidget {
  const TextbookPage({Key? key}) : super(key: key);

  @override
  _TextbookPageState createState() => _TextbookPageState();
}

class _TextbookPageState extends State<TextbookPage> {
  final List<Map<String, dynamic>> pages = [
    {
      'leftPage': {
        'image': 'assets/potions/potion1.png',
        'text': '베라베르토',
        'recipe': [
          {
            'text': '불 켜고 4초 뒤에\n마법의 물 넣기',
            'image': 'assets/ingredients/magic_water.png'
          },
          {
            'text': '그리고 5초 뒤에\n기린의 혀 넣기',
            'image': 'assets/ingredients/giraffe_tongue.png'
          },
          {'text': '그리고 3초 뒤에\n약초 넣기', 'image': 'assets/ingredients/herb.png'},
        ],
      },
      'rightPage': {
        'image': 'assets/potions/potion2.png',
        'text': '세르펜 소르티아',
        'recipe': [
          {
            'text': '불 켜고 4초 뒤에\n뱀 껍질 넣기',
            'image': 'assets/ingredients/snake_skin.jpeg'
          },
          {
            'text': '그리고 5초 뒤에\n다이아몬드 넣기',
            'image': 'assets/ingredients/diamond.png'
          },
          {
            'text': '그리고 3초 뒤에\n드래곤의 피 넣기',
            'image': 'assets/ingredients/dragon_blood.jpeg'
          },
        ],
      },
    },
    {
      'leftPage': {
        'image': 'assets/potions/potion3.png',
        'text': '비페라 이바네스카',
        'recipe': [
          {
            'text': '불 켜고 4초 뒤에\n뱀의 혀 넣기',
            'image': 'assets/ingredients/snake_tongue.png'
          },
          {'text': '그리고 5초 뒤에\n루비 넣기', 'image': 'assets/ingredients/ruby.png'},
          {
            'text': '그리고 3초 뒤에\n마법의 물 넣기',
            'image': 'assets/ingredients/magic_water.png'
          },
        ],
      },
      'rightPage': {
        'image': 'assets/potions/potion4.png',
        'text': '아라니아 액서메이',
        'recipe': [
          {
            'text': '불 켜고 4초 뒤에\n거미 다리 넣기',
            'image': 'assets/ingredients/spider_leg.png'
          },
          {'text': '그리고 5초 뒤에\n약초 넣기', 'image': 'assets/ingredients/herb.png'},
          {
            'text': '그리고 3초 뒤에\n드래곤의 뿔 넣기',
            'image': 'assets/ingredients/dragon_horn.png'
          },
        ],
      },
    },
    {
      'leftPage': {
        'image': 'assets/potions/potion5.png',
        'text': '에이트 슬러그스',
        'recipe': [
          {
            'text': '불 켜고 4초 뒤에\n달팽이 진액 넣기',
            'image': 'assets/ingredients/snail_essence.png'
          },
          {
            'text': '그리고 5초 뒤에\n드래곤 알 넣기',
            'image': 'assets/ingredients/dragon_egg.png'
          },
          {
            'text': '그리고 3초 뒤에\n에메랄드 넣기',
            'image': 'assets/ingredients/emerald.png'
          },
        ],
      },
      'rightPage': {
        'image': 'assets/potions/potion6.png',
        'text': '브라키움 엠멘도',
        'recipe': [
          {
            'text': '불 켜고 4초 뒤에\n기린의 목뼈 넣기',
            'image': 'assets/ingredients/giraffe_bone.png'
          },
          {
            'text': '그리고 5초 뒤에\n천사의 날개 넣기',
            'image': 'assets/ingredients/angel_wing.png'
          },
          {
            'text': '그리고 3초 뒤에\n다이아몬드 넣기',
            'image': 'assets/ingredients/diamond.png'
          },
        ],
      },
    },
  ];

  int _currentPage = 0;

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

  void _showRecipe(String title, List<Map<String, String>> ingredients) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // 배경색 투명
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 배경 이미지
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/recipe_background.png'), // 배경 이미지
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20), // 둥근 모서리
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 36),
                    // 팝업 제목
                    Text(
                      title + " 레시피",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'CustomFont',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 재료 리스트
                    ...ingredients.map(
                      (ingredient) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // 가로 방향 중앙 정렬
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // 세로 방향 중앙 정렬
                          children: [
                            // 재료 이미지
                            Image.asset(
                              ingredient['image']!,
                              width: 120,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),
                            // 재료 이름 텍스트
                            Expanded(
                              child: Text(
                                ingredient['text']!,
                                textAlign: TextAlign.center, // 텍스트 가운데 정렬
                                style: const TextStyle(
                                  fontFamily: 'CustomFont',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //const SizedBox(height: 16),
                    // 닫기 버튼
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '닫기',
                        style: TextStyle(
                          fontFamily: 'CustomFont',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentData = pages[_currentPage];
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.webp"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 책 이미지
          AppBar(
            backgroundColor: Colors.transparent, // AppBar 배경 투명
            elevation: 0, // 그림자 제거
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // 이전 페이지로 이동
              },
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/textbook3.png", // 책 이미지
                  fit: BoxFit.cover,
                ),
                // 이전 페이지 화살표 아이콘 (첫 번째 페이지에서 숨김)
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
                // 다음 페이지 화살표 아이콘 (마지막 페이지에서 숨김)
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
          // 페이지 내용
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 왼쪽 페이지
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showRecipe(
                        currentData['leftPage']['text'],
                        currentData['leftPage']['recipe'],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 70, 10, 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentData['leftPage']['text'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'CustomFont',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            currentData['leftPage']['image'],
                            fit: BoxFit.fitWidth,
                            height: 150,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                // 오른쪽 페이지
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showRecipe(
                        currentData['rightPage']['text'],
                        currentData['rightPage']['recipe'],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 70, 50, 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentData['rightPage']['text'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'CustomFont',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            currentData['rightPage']['image'],
                            fit: BoxFit.cover,
                            height: 150,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 160, // 화면 아래에서 20픽셀 위에 위치
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '레시피를 보려면\n포션을 클릭하세요', // 아래쪽 텍스트 내용
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
