import 'package:http/http.dart' as http;

class ServerAPI {
  static const String baseUrl = 'http://172.10.7.89'; // 서버 주소

  // 카카오 로그인 시작
  static Future<void> startKakaoLogin() async {
    final url = Uri.parse('$baseUrl/auth/kakao'); // 서버의 리다이렉트 엔드포인트
    final response = await http.get(url);

    if (response.statusCode != 302) {
      throw Exception('Failed to start Kakao login');
    }
  }
}