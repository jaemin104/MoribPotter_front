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
    print("lookatthis");
    print(MediaQuery.of(context).size.width);

    // 배경 이미지를 기숙사에 따라 설정
    final backgroundImage = {
      "g_dorm": "assets/dorms/g_dorm.webp",
      "r_dorm": "assets/dorms/r_dorm.webp",
      "s_dorm": "assets/dorms/s_dorm.webp",
      "h_dorm": "assets/dorms/h_dorm.webp",
    }[dorm];

    Widget buildTextButton({
      required String text,
      required VoidCallback onPressed,
      required double top,
      required double left,
    }) {
      return Positioned(
        top: top,
        left: left,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(10), // 클릭 영역 확장
            decoration: BoxDecoration(
              color: Colors.transparent, // 배경 투명
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'CustomFont',
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget buildBigTextButton({
      required String text,
      required VoidCallback onPressed,
      required double top,
      required double left,
    }) {
      return Positioned(
        top: top,
        left: left,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(10), // 클릭 영역 확장
            decoration: BoxDecoration(
              color: Colors.transparent, // 배경 투명
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'CustomFont',
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget buildNonClickableImage({
      required String imagePath,
      required double top,
      required double left,
    }) {
      return Positioned(
        top: top,
        left: left,
        child: Image.asset(
          imagePath,
          width: 500,
          height: 250,
          fit: BoxFit.contain,
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
          // 리더보드 이미지
          buildNonClickableImage(
            imagePath: "assets/upper_wood_sign2.png",
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 250,
          ),
          // 마법 포션 레시피 이미지
          buildNonClickableImage(
            imagePath: "assets/under_wood_sign2.png",
            top: MediaQuery.of(context).size.height - 150,
            left: -155,
          ),
          // 스네이프 교수님의 포션 시험장 이미지
          buildNonClickableImage(
            imagePath: "assets/under_wood_sign2.png",
            top: MediaQuery.of(context).size.height - 150,
            left: 60,
          ),
          // 리더보드 버튼
          buildBigTextButton(
            text: "리더보드",
            onPressed: () {
              Navigator.pushNamed(context, '/leaderboard');
            },
            top: 145,
            left: MediaQuery.of(context).size.width / 2 - 55,
          ),
          // 마법 포션 레시피 버튼
          buildTextButton(
            text: "마법 포션 레시피\n족보 도서관",
            onPressed: () {
              Navigator.pushNamed(context, '/selfStudy');
            },
            top: MediaQuery.of(context).size.height - 100,
            left: 22,
          ),
          // 스네이프 교수님의 포션 시험장 버튼
          buildTextButton(
            text: "스네이프 교수님의\n마법 포션 시험장",
            onPressed: () {
              Navigator.pushNamed(context, '/potionExam');
            },
            top: MediaQuery.of(context).size.height - 100,
            left: MediaQuery.of(context).size.width - 180,
          ),
        ],
      ),
    );
  }
}
