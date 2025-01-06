import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../user_state.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> userScores = [];
  List<Map<String, dynamic>> leaderboard = [];
  int? highestScore;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchUserScores();
    fetchLeaderboard();
  }

  Future<void> fetchUserScores() async {
    final userState = Provider.of<UserState>(context, listen: false);
    final nickname = userState.nickname;
    print('Nickname: $nickname');
    // nickname으로 db에서 user_id 가져오기
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

    // 가져온 user_id로 점수 기록 불러오기
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
          highestScore = userScores.map((e) => e['score'] as int).reduce((a, b) => a > b ? a : b);
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
      appBar: AppBar(
        title: const Text('리더보드'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '내 기록'),
            Tab(text: '전체 랭킹'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 내 기록 탭
          _buildUserScoresTab(),
          // 전체 랭킹 탭
          _buildLeaderboardTab(),
        ],
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: userScores.length,
            itemBuilder: (context, index) {
              final score = userScores[index];
              return ListTile(
                title: Text('점수: ${score['score']}'),
                subtitle: Text('시간: ${score['timestamp']}'),
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
              'Best Player: ${leaderboard.first['nickname']} (${leaderboard.first['dorm']}) - ${leaderboard.first['best_score']}점',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              final player = leaderboard[index];
              return ListTile(
                // 서버에서 받은 rank 값 사용
                leading: Text('#${player['rank']}'),
                title: Text('${player['nickname']} (${player['dorm']})'),
                trailing: Text('${player['best_score']}점'),
              );
            },
          ),
        ),
      ],
    );
  }
}
