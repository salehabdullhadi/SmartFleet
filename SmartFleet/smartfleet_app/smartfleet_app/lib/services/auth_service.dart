import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../config/api_config.dart';
import 'signalr_service.dart';

class AuthService {
  static String get baseUrl => ApiConfig.baseUrl;
  static User? _currentUser;
  static String? _token;
  
  static User? get currentUser => _currentUser;
  static String? get token => _token;
  static bool get isLoggedIn => _currentUser != null && _token != null;

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('🔄 Attempting login to Real API for: $email');
      print('🌐 Using Base URL: $baseUrl');
      print('📡 Full Login URL: $baseUrl/api/authapi/login');
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/authapi/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      ).timeout(Duration(seconds: 30));
      
      print('📡 Login Response Status: ${response.statusCode}');
      print('📋 Login Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _currentUser = User.fromJson(data['data']);
          _token = data['data']['token'];
          
          print('✅ Login successful for user: ${_currentUser!.userName}');
          print('🔐 JWT Token received: ${_token!.substring(0, 30)}...');
          
          // الاتصال بـ SignalR بعد نجاح تسجيل الدخول
          try {
            await SignalRService.connect();
            print('🔔 SignalR connected for real-time notifications');
          } catch (e) {
            print('⚠️ SignalR connection failed, notifications will work in polling mode: $e');
          }
          
          return {
            'success': true,
            'user': _currentUser,
          };
        } else {
          print('❌ Login failed: ${data['message']}');
          return {
            'success': false,
            'message': data['message'] ?? 'Login failed'
          };
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      print('❌ Login Exception: $e');
      return {
        'success': false,
        'message': 'Connection error: $e'
      };
    }
  }
  
  static void logout() {
    _currentUser = null;
    _token = null;
    
    // قطع اتصال SignalR عند تسجيل الخروج
    SignalRService.disconnect();
    
    print('👋 User logged out and SignalR disconnected');
  }
  
  static String? getToken() => _token;
  
  static String getUserRole() {
    if (_currentUser == null) return '';
    
    if (_currentUser!.isAdmin) return 'Fleet Manager';
    if (_currentUser!.isDriver) return 'Driver';
    if (_currentUser!.isUser) return 'User';
    
    return 'Unknown';
  }
} 