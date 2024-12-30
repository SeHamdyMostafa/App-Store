import 'package:appstore/helper/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ApiConfig {
  static Map<String, String> getHeaders(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context, listen: false).currentLanguage;
    final token = 'L1AghBS2rRDL3OkZ4DHl3g1nVMGA4lw3l4sgeuMmDiLxbGHyJweKsbC3hKGl0drDJI0sqF'; // توكن ثابت للاختبار

    return {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
  }
}
