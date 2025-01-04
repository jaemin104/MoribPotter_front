import 'package:flutter/material.dart';

class AssignPage extends StatelessWidget {
  const AssignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final house = ModalRoute.of(context)!.settings.arguments as String;
    final houseDetails = {
      "gryffindor": {
        "name": "아름핀도르",
        "description": "그 이름에 걸맞는 용기를\n지닌 아이들을 가르치리라",
        "flag": "assets/g_flag.webp",
      },
      "ravenclaw": {
        "name": "사랑클로",
        "description": "끝없는 지혜를 추구하는\n이들의 지성이 빛날 것이다",
        "flag": "assets/r_flag.webp",
      },
      "slytherin": {
        "name": "진리데린",
        "description": "야망과 결단으로\n위대한 운명을 설계하리라",
        "flag": "assets/s_flag.webp",
      },
      "hufflepuff": {
        "name": "성실푸프",
        "description": "언제나 정의와 충성심을\n품은 이들의 쉼터가 되리라",
        "flag": "assets/h_flag.webp",
      },
    };

    final houseData = houseDetails[house]!;

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
          // 다른 요소들
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 플래그 이미지
                Image.asset(
                  houseData["flag"]!,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                // 기숙사 이름
                Text(
                  houseData["name"]!,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'CustomFont',
                  ),
                ),
                const SizedBox(height: 16),
                // 기숙사 설명
                Text(
                  houseData["description"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'CustomFont',
                  ),
                ),
                const SizedBox(height: 30),
                // 버튼
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                  arguments: house,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text("홈 화면으로 이동"),
            ),
          ),
        ],
      ),
    );
  }
}
