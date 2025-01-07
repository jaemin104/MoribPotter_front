import 'package:flutter/material.dart';
import '../user_state.dart'; // UserState를 불러옵니다.
import 'package:provider/provider.dart'; // Provider를 사용합니다.

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

    Widget buildImageButton({
      required String imagePath,
      required String text,
      required VoidCallback onPressed,
    }) {
      return GestureDetector(
        onTap: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 버튼 배경 이미지
            Image.asset(
              imagePath,
              width: 500, // 이미지의 가로 크기
              height: 250, // 이미지의 세로 크기
              fit: BoxFit.contain,
            ),
            // 버튼 텍스트
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'CustomFont',
                color: Colors.white, // 텍스트 색상
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

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
          // 리더보드 버튼 (상단 중앙)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: buildImageButton(
                imagePath: "assets/upper_wood_sign2.png",
                text: "리더보드",
                onPressed: () {
                  Navigator.pushNamed(context, '/leaderboard');
                },
              ),
            ),
          ),
          // 마법 포션 레시피 (왼쪽 아래)
          Positioned(
            bottom: 0, // 화면 아래에서 16픽셀 위
            right: 130, // 화면 왼쪽에서 16픽셀 오른쪽
            child: buildImageButton(
              imagePath: "assets/under_wood_sign2.png",
              text: "마법 포션 레시피\n족보 도서관\n\n",
              onPressed: () {
                Navigator.pushNamed(context, '/selfStudy');
              },
            ),
          ),
          // 마법 포션 시험장 (오른쪽 아래)
          Positioned(
            bottom: 0, // 화면 아래에서 16픽셀 위
            left: 130, // 화면 오른쪽에서 16픽셀 왼쪽
            child: buildImageButton(
              imagePath: "assets/under_wood_sign2.png",
              text: "류네이프 교수님의\n마법 포션 시험장\n\n",
              onPressed: () {
                Navigator.pushNamed(context, '/potionExam');
              },
            ),
          ),
        ],
      ),
    );
  }
}
