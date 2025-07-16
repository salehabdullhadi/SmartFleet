import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConfig {
  // إعدادات مختلفة للبيئات المختلفة
  static const String _localhostUrl = 'http://localhost:50993';
  static const String _emulatorUrl = 'http://10.0.2.2:50993';
  static String _deviceUrl = 'http://192.168.144.78:50993';
  
  static String get baseUrl {
    String url;
    
    // للويب، استخدم localhost
    if (kIsWeb) {
      url = _localhostUrl;
      print('🌐 API Base URL: $url');
      print('📱 Platform: Web');
      return url;
    }
    
    // للموبايل والديسكتوب
    try {
      if (Platform.isAndroid) {
        // للجهاز الحقيقي استخدم IP الحقيقي للكمبيوتر
        url = _deviceUrl;
      } else if (Platform.isIOS) {
        // للمحاكي iOS استخدم localhost
        url = _localhostUrl;
      } else {
        // للديسكتوب استخدم localhost
        url = _localhostUrl;
      }
      print('🌐 API Base URL: $url');
      print('📱 Platform: ${Platform.operatingSystem}');
    } catch (e) {
      // fallback للويب
      url = _localhostUrl;
      print('🌐 API Base URL: $url (fallback)');
      print('📱 Platform: Web (fallback)');
    }
    
    return url;
  }
  
  // للاختبار على بيئات مختلفة
  static String get localhostUrl => _localhostUrl;
  static String get emulatorUrl => _emulatorUrl;
  static String get deviceUrl => _deviceUrl;
  
  // تحديث عنوان IP للجهاز الحقيقي
  static void updateDeviceUrl(String newUrl) {
    _deviceUrl = newUrl;
  }
  
  // للتديبج
  static void printCurrentConfig() {
    print('🌐 Current API Base URL: $baseUrl');
    print('📱 Platform: ${Platform.operatingSystem}');
  }
} 