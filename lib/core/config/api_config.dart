import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class ApiConfig {
  static String get baseUrl {
    if (kIsWeb) {
      // Web: Use localhost
      return 'http://192.168.1.11:8080/api';
    } else if (Platform.isAndroid) {
      // Android Emulator: Use 10.0.2.2 to reach host machine
      return 'http://10.0.2.2:8080/api';
    } else if (Platform.isIOS) {
      // iOS Simulator: Use localhost
      return 'http://192.168.1.11:8080/api';
    } else {
      // Fallback
      return 'http://192.168.1.11:8080/api';
    }
  }
}
