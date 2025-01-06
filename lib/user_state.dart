import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String? _nickname;
  String? _dorm;

  String? get nickname => _nickname;
  String? get dorm => _dorm;

  void setNickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }

  void setDorm(String dorm) {
    _dorm = dorm;
    notifyListeners();
  }
}