import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 사용
import '../user_state.dart'; // 전역 상태 클래스

class AssignPage extends StatelessWidget {
  const AssignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 전역변수 가져오기
    final userState = Provider.of<UserState>(context, listen: false);
    // 전역 변수에서 dorm 정보 가져오기
    final dorm = userState.dorm; // 기숙사 정보
    final nickname = userState.nickname; // 닉네임 정보

    // 기숙사 상세 정보
    final houseDetails = {
      "g_dorm": {
        "name": "아름핀도르",
        "description": "그 이름에 걸맞는 용기를\n지닌 아이들을 가르치리라",
        "flag": "assets/flags/g_flag.webp",
      },
      "r_dorm": {
        "name": "사랑클로",
        "description": "끝없는 지혜를 추구하는\n이들의 지성이 빛날 것이다",
        "flag": "assets/flags/r_flag.webp",
      },
      "s_dorm": {
        "name": "진리데린",
        "description": "야망과 결단으로\n위대한 운명을 설계하리라",
        "flag": "assets/flags/s_flag.webp",
      },
      "h_dorm": {
        "name": "성실푸프",
        "description": "언제나 정의와 충성심을\n품은 이들의 쉼터가 되리라",
        "flag": "assets/flags/h_flag.webp",
      },
    };

    // dorm에 해당하는 상세 정보 가져오기
    final houseData = houseDetails[dorm]!;

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
          // 메인 콘텐츠
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
                // 기숙사 이동 버튼
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/home', // home_page로 이동
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.7), // 버튼 배경색
                      foregroundColor: Colors.deepPurpleAccent, // 텍스트 색상
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      "기숙사로 이동",
                      style: TextStyle(
                          fontFamily: 'CustomFont',
                          color: Colors.deepPurpleAccent,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
