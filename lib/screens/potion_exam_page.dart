import 'package:flutter/material.dart';
import 'real_exam_page.dart';

class PotionExamPage extends StatelessWidget {
  const PotionExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("assets/potion_exam_background2.png"), // 배경 이미지 경로
            fit: BoxFit.cover, // 화면을 채우도록 설정
          ),
        ),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: Colors.transparent, // AppBar 배경 투명
              elevation: 0, // 그림자 제거
              leading: IconButton(
                icon: Container(
                  width: 40, // 원의 너비
                  height: 40, // 원의 높이
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7), // 원의 배경색
                    shape: BoxShape.circle, // 원 모양
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white, // 화살표 아이콘 색상
                    size: 24, // 화살표 아이콘 크기
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // 이전 페이지로 이동
                },
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.45), // x, y 위치 (비율)
              child: Text(
                '포션 시험을 시작하려면\n    칠판을 클릭하세요',
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
              alignment: Alignment(0.0, 0.0), // 버튼 위치 (텍스트 아래)
              child: InkWell(
                onTap: () {
                  print('Button pressed'); // 디버깅 로그
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RealExamPage()),
                  );
                },
                child: Container(
                  width: 100,
                  height: 200,
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
