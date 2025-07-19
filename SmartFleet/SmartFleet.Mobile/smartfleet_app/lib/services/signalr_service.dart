import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import '../models/notification.dart';
import '../config/api_config.dart';
import 'auth_service.dart';

class SignalRService {
  static HubConnection? _connection;
  static StreamController<NotificationModel>? _notificationController;
  static StreamController<int>? _notificationCountController;
  
  static Stream<NotificationModel>? get notificationStream => _notificationController?.stream;
  static Stream<int>? get notificationCountStream => _notificationCountController?.stream;
  
  static bool get isConnected => _connection?.state == HubConnectionState.Connected;

  static Future<void> connect() async {
    if (_connection?.state == HubConnectionState.Connected) {
      return;
    }

    try {
      print('🔄 Connecting to SignalR Hub...');
      
      final token = AuthService.token;
      if (token == null) {
        print('❌ No JWT token available for SignalR connection');
        return;
      }

      print('🔐 Using JWT token for SignalR: ${token.substring(0, 50)}...');

      _notificationController ??= StreamController<NotificationModel>.broadcast();
      _notificationCountController ??= StreamController<int>.broadcast();

      final encodedToken = Uri.encodeComponent(token);
      final hubUrl = "${ApiConfig.baseUrl}/hubs/Notify?access_token=$encodedToken";
      print('🌐 SignalR Hub URL: ${hubUrl.substring(0, 80)}...');

      _connection = HubConnectionBuilder()
          .withUrl(hubUrl,
              options: HttpConnectionOptions(
                transport: HttpTransportType.WebSockets,
              ))
          .withAutomaticReconnect()
          .build();

      // استماع للإشعارات الجديدة
      _connection!.on("ReceiveNotification", (arguments) {
        try {
          if (arguments != null && arguments.isNotEmpty) {
            print('📨 New notification received via SignalR: ${arguments[0]}');
            
            final notificationData = arguments[0] as Map<String, dynamic>;
            final notification = NotificationModel.fromJson(notificationData);
            
            _notificationController?.add(notification);
            print('✅ Notification added to stream: ${notification.title}');
          }
        } catch (e) {
          print('❌ Error processing notification: $e');
        }
      });

      // استماع لتحديثات عدد الإشعارات
      _connection!.on("NotificationCountUpdate", (arguments) {
        try {
          if (arguments != null && arguments.isNotEmpty) {
            final count = arguments[0] as int;
            _notificationCountController?.add(count);
            print('🔢 Notification count updated: $count');
          }
        } catch (e) {
          print('❌ Error processing notification count: $e');
        }
      });

      // معالجة حالات الاتصال
      _connection!.onclose(({Exception? error}) {
        print('🔌 SignalR connection closed: ${error?.toString() ?? 'No error'}');
      });

      _connection!.onreconnecting(({Exception? error}) {
        print('🔄 SignalR reconnecting: ${error?.toString() ?? 'Unknown reason'}');
      });

      _connection!.onreconnected(({String? connectionId}) {
        print('✅ SignalR reconnected with ID: ${connectionId ?? 'Unknown'}');
      });

      await _connection!.start();
      print('✅ SignalR connected successfully');
      
    } catch (e) {
      print('❌ Failed to connect to SignalR: $e');
    }
  }

  static Future<void> disconnect() async {
    try {
      print('🔌 Disconnecting from SignalR...');
      
      await _connection?.stop();
      _connection = null;
      
      await _notificationController?.close();
      _notificationController = null;
      
      await _notificationCountController?.close();
      _notificationCountController = null;
      
      print('👋 SignalR disconnected');
    } catch (e) {
      print('❌ Error disconnecting SignalR: $e');
    }
  }

  static Future<void> sendNotificationToUser(String userId, Map<String, dynamic> notification) async {
    try {
      if (_connection?.state == HubConnectionState.Connected) {
        await _connection!.invoke("SendNotificationToUser", args: [userId, notification]);
        print('📤 Notification sent to user $userId');
      } else {
        print('❌ Cannot send notification: SignalR not connected');
      }
    } catch (e) {
      print('❌ Error sending notification: $e');
    }
  }

  static Future<void> sendNotificationToAll(Map<String, dynamic> notification) async {
    try {
      if (_connection?.state == HubConnectionState.Connected) {
        await _connection!.invoke("SendNotificationToAll", args: [notification]);
        print('📤 Notification sent to all users');
      } else {
        print('❌ Cannot send notification: SignalR not connected');
      }
    } catch (e) {
      print('❌ Error sending notification: $e');
    }
  }
} 