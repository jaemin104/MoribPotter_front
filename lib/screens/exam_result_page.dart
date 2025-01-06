import 'package:flutter/material.dart';
import 'home_page.dart';

class ExamResultPage extends StatelessWidget {
  const ExamResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 (background)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.webp"), // 배경 이미지 경로
                fit: BoxFit.cover, // 화면을 채우도록 설정
              ),
            ),
          ),
          // exam_result 이미지를 배치
          Center(
            child: Image.asset(
              'assets/exam_result.png', // exam_result 이미지 경로
              width: MediaQuery.of(context).size.width, // 가로 길이에 맞게 설정
              fit: BoxFit.contain, // 이미지 비율 유지
            ),
          ),
          // 시험 결과 내용
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30), // exam_result 위로 간격
                // 타이틀
                const Text(
                  '홍길동 님 3번째 포션 시험 결과',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // 결과 항목 1
                _buildResultRow(
                  'assets/potions/potion1.png', // 포션 이미지 경로
                  '3초에 다이아몬드 넣기 성공 +20점\n3초에 다이아몬드 넣기 성공 +20점\n3초에 다이아몬드 넣기 성공 +20점',
                ),
                const SizedBox(height: 10),
                // 결과 항목 2
                _buildResultRow(
                  'assets/potions/potion2.png',
                  '3초에 다이아몬드 넣기 성공 +20점\n3초에 다이아몬드 넣기 성공 +20점\n3초에 다이아몬드 넣기 성공 +20점',
                ),
                const SizedBox(height: 10),
                // 결과 항목 3
                _buildResultRow(
                  'assets/potions/potion3.png',
                  '3초에 다이아몬드 넣기 성공 +20점\n3초에 다이아몬드 넣기 성공 +20점\n3초에 다이아몬드 넣기 성공 +20점',
                ),
                const SizedBox(height: 20),
                // 총점
                const Text(
                  '총점: 252점',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          // 홈으로 돌아가기 버튼 (고정된 위치)
          Positioned(
            bottom: 50, // 화면 아래에서 50픽셀 위에 배치
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home'); // home_page.dart로 이동
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.black.withOpacity(0.7),
                ),
                child: const Text(
                  '기숙사로 돌아가기',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CustomFont',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 결과 Row를 빌드하는 함수
  Widget _buildResultRow(String imagePath, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 가로 중앙 정렬
      crossAxisAlignment: CrossAxisAlignment.center, // 세로 중앙 정렬
      children: [
        // 포션 이미지와 이름
        Column(
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5), // 이미지와 텍스트 간격
            const Text(
              '포션 이름', // 이미지만 아래에 텍스트 추가
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'CustomFont',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(width: 20),
        // 포션 세부 내용
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'CustomFont',
            ),
          ),
        ),
      ],
    );
  }
}
