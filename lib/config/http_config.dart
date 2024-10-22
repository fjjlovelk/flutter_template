import 'package:flutter_template/flavors.dart';

class HttpConfig {
  static String baseUrl = F.apiBaseUrl;
  static Duration connectTimeout = const Duration(seconds: 30);
  static Duration receiveTimeout = const Duration(seconds: 30);
}
