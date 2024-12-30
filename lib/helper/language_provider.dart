import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLanguage = 'en'; // اللغة الافتراضية

  String get currentLanguage => _currentLanguage;

  void setLanguage(String lang) {
    _currentLanguage = lang;
    notifyListeners(); // تحديث الـ UI إذا تغيرت اللغة
  }

  static of(BuildContext context, {required bool listen}) {}
}
