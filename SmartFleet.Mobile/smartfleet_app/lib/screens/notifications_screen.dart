import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/signalr_service.dart';
import '../services/notification_sound_service.dart';
import '../models/notification.dart';
import '../widgets/loading_widget.dart';
import '../widgets/animated_widgets.dart';
import '../theme/app_theme.dart';
import 'dart:async';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  String? _error;
  StreamSubscription<NotificationModel>? _notificationSubscription;
  late Timer _timeUpdateTimer;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _listenToSignalRNotifications();
    _startTimeUpdateTimer();
  }

  void _startTimeUpdateTimer() {
    _timeUpdateTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          // إعادة بناء الواجهة لتحديث أوقات الإشعارات
        });
      }
    });
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${(difference.inDays / 7).floor()}w ago';
    }
  }

  void _listenToSignalRNotifications() {
    // الاستماع للإشعارات الجديدة من SignalR
    _notificationSubscription = SignalRService.notificationStream?.listen((newNotification) async {
      if (mounted) {
        // تشغيل صوت التنبيه
        await NotificationSoundService.playNotificationSound();
        
        setState(() {
          // إضافة الإشعار الجديد في بداية القائمة
          _notifications.insert(0, newNotification);
        });
        
        // إظهار تنبيه مُحسّن للإشعار الجديد
        final now = DateTime.now();
        final timeString = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              '🔔 New Notification',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '⏰ $timeString',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          newNotification.title,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.7),
                    size: 16,
                  ),
                ],
              ),
            ),
            backgroundColor: AppTheme.primaryColor,
            duration: Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(16),
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.white,
              backgroundColor: Colors.white.withOpacity(0.2),
              onPressed: () {
                // Navigate to notification details if needed
              },
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    _timeUpdateTimer.cancel();
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final notifications = await ApiService.getNotifications();
      setState(() {
        _notifications = notifications;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          // مؤشر حالة SignalR
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: SignalRService.isConnected 
                        ? AppTheme.successColor 
                        : AppTheme.dangerColor,
                    shape: BoxShape.circle,
                    boxShadow: SignalRService.isConnected 
                        ? [BoxShadow(
                            color: AppTheme.successColor.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          )]
                        : [],
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  SignalRService.isConnected ? 'Live' : 'Offline',
                  style: TextStyle(
                    fontSize: 12, 
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? LoadingWidget()
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 64,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Error loading notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _error!,
                        style: TextStyle(color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _loadNotifications,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2E3A7A),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        return StaggeredListAnimation(
                          index: index,
                          child: _buildNotificationCard(notification),
                        );
                      },
                    ),
    );
  }

  Widget _buildEmptyState() {
    return SlideInAnimation(
      index: 0,
      delay: 500,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.notifications_none_outlined,
                size: 80,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'No Notifications',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Your notifications will appear here when available',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    Color typeColor = _getNotificationColor(notification.type);
    IconData typeIcon = _getNotificationIcon(notification.type);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: notification.isRead 
            ? Border.all(color: AppTheme.textTertiaryColor.withOpacity(0.3), width: 1)
            : Border.all(color: typeColor.withOpacity(0.4), width: 2),
        boxShadow: notification.isRead ? AppTheme.cardShadow : AppTheme.elevatedShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Mark as read functionality can be added here
            if (!notification.isRead) {
              setState(() {
                notification.isRead = true;
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                  // Icon
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: typeColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      typeIcon,
                      color: typeColor,
                      size: 24,
                    ),
                  ),
                
                                  SizedBox(width: 16),
                  
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and status
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: notification.isRead 
                                      ? FontWeight.w500 
                                      : FontWeight.bold,
                                  color: notification.isRead 
                                      ? AppTheme.textSecondaryColor 
                                      : AppTheme.textPrimaryColor,
                                ),
                              ),
                            ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: typeColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      
                      SizedBox(height: 4),
                      
                                              // Message
                        Text(
                          notification.message,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondaryColor,
                            height: 1.4,
                          ),
                        ),
                      
                      SizedBox(height: 8),
                      
                                              // Footer
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: typeColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: typeColor.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                notification.type.toUpperCase(),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: typeColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _getTimeAgo(notification.createdAt),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textTertiaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${notification.createdAt.hour.toString().padLeft(2, '0')}:${notification.createdAt.minute.toString().padLeft(2, '0')}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textTertiaryColor.withOpacity(0.7),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Color _getNotificationColor(String type) {
    switch (type.toLowerCase()) {
      case 'info':
      case 'information':
        return AppTheme.infoColor;
      case 'success':
        return AppTheme.successColor;
      case 'warning':
        return AppTheme.warningColor;
      case 'error':
      case 'alert':
        return AppTheme.dangerColor;
      case 'trip':
        return AppTheme.primaryColor;
      default:
        return AppTheme.textSecondaryColor;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'info':
      case 'information':
        return Icons.info_outline;
      case 'success':
        return Icons.check_circle_outline;
      case 'warning':
        return Icons.warning_amber_outlined;
      case 'error':
      case 'alert':
        return Icons.error_outline;
      case 'trip':
        return Icons.route_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }
} 