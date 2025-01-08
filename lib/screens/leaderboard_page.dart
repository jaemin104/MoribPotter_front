import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // 날짜 포맷을 위해 추가
import '../user_state.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int _selectedTab = 0; // 현재 선택된 탭 (0: 내 기록, 1: 전체 랭킹)
  List<Map<String, dynamic>> userScores = [];
  List<Map<String, dynamic>> leaderboard = [];
  int? highestScore;

  @override
  void initState() {
    super.initState();
    fetchUserScores();
    fetchLeaderboard();
  }

  Future<void> fetchUserScores() async {
    final userState = Provider.of<UserState>(context, listen: false);
    final nickname = userState.nickname;

    final response = await http.post(
      Uri.parse('http://172.10.7.89/auth/get_user_id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nickname': nickname}),
    );

    int userID = 0;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      userID = data['user_id'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('유저 ID 불러오기 실패: ${response.body}')),
      );
    }

    final response2 = await http.post(
      Uri.parse('http://172.10.7.89/scores/get_user_scores'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userID}),
    );

    if (response2.statusCode == 200) {
      final data = jsonDecode(response2.body);
      setState(() {
        userScores = List<Map<String, dynamic>>.from(data);
        if (userScores.isNotEmpty) {
          highestScore = userScores
              .map((e) => e['score'] as int)
              .reduce((a, b) => a > b ? a : b);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('점수 기록 불러오기 실패: ${response2.body}')),
      );
    }
  }

  Future<void> fetchLeaderboard() async {
    final response = await http.get(
      Uri.parse('http://172.10.7.89/scores/leaderboard'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        leaderboard = List<Map<String, dynamic>>.from(data);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('리더보드 불러오기 실패: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          // 콘텐츠
          Column(
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
              // 커스텀 탭 버튼
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTabButton('내 기록', 0),
                    _buildTabButton('전체 랭킹', 1),
                  ],
                ),
              ),
              Expanded(
                child: _selectedTab == 0
                    ? _buildUserScoresTab()
                    : _buildLeaderboardTab(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.deepPurpleAccent
                : Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'CustomFont',
                color: isSelected ? Colors.white : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserScoresTab() {
    return Column(
      children: [
        if (highestScore != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '최고 점수: $highestScore',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'CustomFont',
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
        Expanded(
          child: userScores.isEmpty
              ? const Center(
            child: Text(
              '점수 기록이 없습니다.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'CustomFont',
              ),
            ),
          )
              : ListView.builder(
            itemCount: userScores.length,
            itemBuilder: (context, index) {
              final score = userScores[index];

              // 시간 포맷 변환
              final DateTime timestamp = DateTime.parse(score['timestamp']);
              final String formattedTime =
              DateFormat('yyyy-MM-dd HH:mm').format(timestamp);

              return Card(
                color: Colors.black.withOpacity(0.5),
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    '점수: ${score['score']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'CustomFont',
                    ),
                  ),
                  subtitle: Text(
                    '$formattedTime', // 변환된 시간 표시
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'CustomFont',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardTab() {
    return Column(
      children: [
        if (leaderboard.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '최고 점수: ${leaderboard.first['nickname']} (${leaderboard.first['dorm']}) - ${leaderboard.first['best_score']}점',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'CustomFont',
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
        Expanded(
          child: leaderboard.isEmpty
              ? const Center(
            child: Text(
              '랭킹 데이터가 없습니다.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'CustomFont',
              ),
            ),
          )
              : ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              final player = leaderboard[index];
              return Card(
                color: Colors.black.withOpacity(0.5),
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Text(
                    '#${player['rank']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CustomFont',
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  title: Text(
                    '${player['nickname']} (${player['dorm']})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'CustomFont',
                    ),
                  ),
                  trailing: Text(
                    '${player['best_score']}점',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'CustomFont',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}