import 'package:flutter/material.dart';
import '../user_state.dart'; // UserState를 불러옵니다.
import 'package:provider/provider.dart'; // Provider를 사용합니다.
import 'self_study_page.dart'; // SelfStudyPage를 불러옵니다.
import 'potion_exam_page.dart'; // PotionExamPage를 불러옵니다.

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 전역 상태에서 기숙사 정보 가져오기
    final userState = Provider.of<UserState>(context, listen: false);
    final dorm = userState.dorm;

    // 배경 이미지를 기숙사에 따라 설정
    final backgroundImage = {
      "g_dorm": "assets/g_dorm.webp",
      "r_dorm": "assets/r_dorm.webp",
      "s_dorm": "assets/s_dorm.webp",
      "h_dorm": "assets/h_dorm.webp",
    }[dorm];

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 왼쪽 아래 버튼
          Positioned(
            bottom: 16,
            left: 16,
            child: SizedBox(
              width: 160,
              height: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.7), // 버튼 배경색
                  foregroundColor: Colors.deepPurpleAccent, // 텍스트 색상
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/selfStudy');
                },
                child: const Text(
                  '마법 포션 레시피\n   족보 도서관',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'CustomFont',
                  ),
                ),
              ),
            ),
          ),
          // 오른쪽 아래 버튼
          Positioned(
            bottom: 16,
            right: 16,
            child: SizedBox(
              width: 160,
              height: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.7), // 버튼 배경색
                  foregroundColor: Colors.deepPurpleAccent, // 텍스트 색상
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/potionExam');
                },
                child: const Text(
                  '류네이프 교수님의\n 마법 포션 시험장',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: 'CustomFont'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
