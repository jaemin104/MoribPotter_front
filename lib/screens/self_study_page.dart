import 'package:flutter/material.dart';
import 'textbook_page.dart';

class SelfStudyPage extends StatelessWidget {
  const SelfStudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/self_study_background.png"), // 배경 이미지 경로
            fit: BoxFit.cover, // 화면을 채우도록 설정
          ),
        ),
        child: Stack(
          children: [
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
            Align(
              alignment: Alignment(0.0, 0.25), // x, y 위치 (비율)
              child: Text(
                '자습을 시작하려면\n  책을 클릭하세요',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 4.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.45, 0.8), // 버튼 위치 (텍스트 아래)
              child: InkWell(
                onTap: () {
                  print('Button pressed'); // 디버깅 로그
                  Navigator.pushNamed(context, '/textbookPage');
                },
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
