import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../services/signalr_service.dart';
import '../services/notification_sound_service.dart';
import '../widgets/loading_widget.dart';
import '../widgets/animated_widgets.dart';
import '../models/notification.dart';
import '../theme/app_theme.dart';
import 'trips_screen.dart';
import 'orders_screen.dart';
import 'vehicles_screen.dart';
import 'drivers_screen.dart';
import 'notifications_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  Map<String, dynamic> _counts = {};
  bool _isLoading = true;
  int? _localNotificationCount; // متغير لحفظ العداد المحدث محلياً

  // Timer للتحكم في أوقات التحديث
  Timer? _timeUpdateTimer;

  // Animation controllers
  late AnimationController _fabAnimationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fabAnimation;
  late Animation<double> _cardAnimation;

  // الاستماع للإشعارات الجديدة
  StreamSubscription<NotificationModel>? _notificationSubscription;
  StreamSubscription<int>? _notificationCountSubscription;

  // SmartFleet Backend Color Scheme - نفس ألوان الباك إند
  static const Color primaryColor = Color(0xFF20B2AA);      // #20B2AA - فيروزي فاتح
  static const Color secondaryColor = Color(0xFF17A2B8);    // معدل ليناسب التصميم
  static const Color successColor = Color(0xFF198754);      // #198754 - أخضر
  static const Color infoColor = Color(0xFF0DCAF0);         // #0dcaf0 - أزرق فاتح
  static const Color warningColor = Color(0xFFFFC107);      // #ffc107 - أصفر
  static const Color dangerColor = Color(0xFFDC3545);       // #dc3545 - أحمر
  static const Color lightColor = Color(0xFFF8F9FA);        // #f8f9fa - رمادي فاتح جداً
  static const Color darkColor = Color(0xFF212529);         // #212529 - رمادي غامق
  static const Color backgroundColor = Color(0xFFF4F4F4);   // #f4f4f4 - خلفية
  static const Color purpleColor = Color(0xFF6F42C1);       // #6f42c1 - بنفسجي

  @override
  void initState() {
    super.initState();

    // تهيئة الـ Animation Controllers
    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _cardAnimationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.elasticOut),
    );

    _cardAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardAnimationController, curve: Curves.easeInOut),
    );

    // بدء الـ Animations
    _fabAnimationController.forward();
    _cardAnimationController.forward();
    
    // تحميل البيانات والاستماع للإشعارات
    _loadDashboardData();
    _setupSignalR();
    _startTimeUpdateTimer();
  }

  void _setupSignalR() {
    // الاستماع للإشعارات الجديدة
    _notificationSubscription = SignalRService.notificationStream?.listen((notification) {
      print('📨 New notification received: ${notification.title}');
      if (mounted) {
      _showNotificationToast(notification);
      _playNotificationSound();
        // تحديث العداد محلياً بدون إعادة تحميل البيانات
        setState(() {
          _localNotificationCount = (_localNotificationCount ?? _counts['notifications'] ?? 0) + 1;
          _counts['notifications'] = _localNotificationCount!;
        });
        print('🔢 Notification count increased to: ${_localNotificationCount}');
      }
    });
    
    // الاستماع لتحديثات عدد الإشعارات من SignalR
    _notificationCountSubscription = SignalRService.notificationCountStream?.listen((newCount) {
      print('🔢 Notification count updated from SignalR: $newCount');
      if (mounted && _localNotificationCount == null) {
        // تحديث العداد فقط إذا لم يتم تحديثه محلياً
        setState(() {
          _counts['notifications'] = newCount;
        });
      }
    });
  }

  void _showNotificationToast(NotificationModel notification) {
    final now = DateTime.now();
    final timeString = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    
    Fluttertoast.showToast(
      msg: "🔔 ${notification.title}\n${notification.message}\n⏰ $timeString - Just now",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: primaryColor.withOpacity(0.9),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _playNotificationSound() {
    try {
      NotificationSoundService.playNotificationSound();
      print('🔊 Notification sound played');
    } catch (e) {
      print('❌ Error playing notification sound: $e');
    }
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

  void _startTimeUpdateTimer() {
    _timeUpdateTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          // إعادة بناء الواجهة لتحديث أوقات الإشعارات
        });
      }
    });
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _cardAnimationController.dispose();
    _timeUpdateTimer?.cancel();
    
    // إنهاء الاستماع للإشعارات
    _notificationSubscription?.cancel();
    _notificationCountSubscription?.cancel();
    
    super.dispose();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final counts = await ApiService.getDashboardCounts();
      
      if (mounted) {
        setState(() {
          // إذا كان لدينا عداد محلي، استخدمه بدلاً من العداد من الخادم
          if (_localNotificationCount != null) {
            counts['notifications'] = _localNotificationCount!;
          }
          _counts = counts;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Error loading dashboard: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.logout, color: dangerColor),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: dangerColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                AuthService.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    if (user == null) {
      return LoginScreen();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: _isLoading ? _buildLoadingState() : _buildMainContent(user),
      // إزالة الـ FloatingActionButton من هنا
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'SmartFleet',
        style: TextStyle(
          color: darkColor,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
      actions: [
        AnimatedBuilder(
          animation: _fabAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _fabAnimation.value,
              child: Container(
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: _isLoading ? null : _loadDashboardData,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: _isLoading 
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(width: 8),
        PopupMenuButton<String>(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.more_vert, color: primaryColor),
          ),
          onSelected: (value) {
            if (value == 'logout') {
              _logout();
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: dangerColor),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Loading data...',
            style: TextStyle(
              fontSize: 16,
              color: darkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(user) {
    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      color: primaryColor,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeCard(user),
                  SizedBox(height: 20),
                  _buildRolePermissionsCard(user),
                  SizedBox(height: 32),
                  _buildOverviewSection(user),
                  SizedBox(height: 32),
                  _buildStatusSection(),
                  SizedBox(height: 20), // مساحة عادية في الأسفل
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(user) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50,
        child: FadeInAnimation(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.waving_hand,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            user.userName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    user.primaryRole,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRolePermissionsCard(user) {
    String permissions = '';
    Color cardColor = infoColor;
    IconData roleIcon = Icons.person;

    if (user.isFleetManager) {
      permissions = 'Full access: Orders, Trips, Vehicles, Drivers & Notifications';
      cardColor = successColor;
      roleIcon = Icons.admin_panel_settings;
    } else if (user.isDriver) {
      permissions = 'Access: Trips & Notifications';
      cardColor = warningColor;
      roleIcon = Icons.drive_eta;
    } else if (user.isUser) {
      permissions = 'Access: Trips, Orders & Notifications';
      cardColor = infoColor;
      roleIcon = Icons.person;
    }

    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 30,
        child: FadeInAnimation(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: cardColor.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: cardColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    roleIcon,
                    color: cardColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Role: ${user.primaryRole}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        permissions,
                        style: TextStyle(
                          fontSize: 12,
                          color: darkColor.withOpacity(0.7),
                        ),
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

  Widget _buildOverviewSection(user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimationConfiguration.staggeredList(
          position: 2,
          duration: Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 30,
            child: FadeInAnimation(
              child: Text(
                'Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.2, // مناسب للتصميم الأفقي الجديد
          ),
          itemCount: _getStatCards(user).length,
          itemBuilder: (context, index) {
            final card = _getStatCards(user)[index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: Duration(milliseconds: 600),
              columnCount: 2,
              child: ScaleAnimation(
                scale: 0.5,
                child: FadeInAnimation(
                  child: _buildEnhancedStatCard(
                    card['title'],
                    card['count'],
                    card['icon'],
                    card['color'],
                    () => _navigateToScreen(card['screen']),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getStatCards(user) {
    final List<Map<String, dynamic>> cards = [];

    // جميع الأدوار يرون الإشعارات
    cards.add({
      'title': 'Notifications',
      'count': _counts['notifications'] ?? 0,
      'icon': Icons.notifications,
      'color': primaryColor,
      'screen': NotificationsScreen(),
    });

    if (user.isFleetManager) {
      // Fleet Manager: orders, trips, vehicles, drivers, notifications
      cards.addAll([
        {
          'title': 'Orders',
          'count': _counts['orders'] ?? 0,
          'icon': Icons.description,
          'color': warningColor,
          'screen': OrdersScreen(),
        },
        {
          'title': 'Trips',
          'count': _counts['trips'] ?? 0,
          'icon': Icons.route,
          'color': infoColor,
          'screen': TripsScreen(),
        },
        {
          'title': 'Vehicles',
          'count': _counts['vehicles'] ?? 0,
          'icon': Icons.directions_car,
          'color': primaryColor,
          'screen': VehiclesScreen(),
        },
        {
          'title': 'Drivers',
          'count': _counts['drivers'] ?? 0,
          'icon': Icons.badge,
          'color': successColor,
          'screen': DriversScreen(),
        },
      ]);
    } else if (user.isDriver) {
      // Driver: trips, notifications
      cards.add({
        'title': 'Trips',
        'count': _counts['trips'] ?? 0,
        'icon': Icons.route,
        'color': infoColor,
        'screen': TripsScreen(),
      });
    } else if (user.isUser) {
      // User: trips, orders, notifications
      cards.addAll([
        {
          'title': 'Trips',
          'count': _counts['trips'] ?? 0,
          'icon': Icons.route,
          'color': infoColor,
          'screen': TripsScreen(),
        },
        {
          'title': 'Orders',
          'count': _counts['orders'] ?? 0,
          'icon': Icons.description,
          'color': warningColor,
          'screen': OrdersScreen(),
        },
      ]);
    }

    return cards;
  }

  Widget _buildEnhancedStatCard(String title, int count, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
              child: Container(
          padding: EdgeInsets.all(4), // تقليل الـ padding لأقل مستوى
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: color,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: darkColor.withOpacity(0.8),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 2),
                  Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimationConfiguration.staggeredList(
          position: 5,
          duration: Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 30,
            child: FadeInAnimation(
              child: Text(
                'System Status',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        AnimationConfiguration.staggeredList(
          position: 6,
          duration: Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 30,
            child: FadeInAnimation(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildStatusItem('API Connection', true, successColor),
                    SizedBox(height: 12),
                    _buildStatusItem('Real-time Updates', true, successColor),
                    SizedBox(height: 12),
                    _buildStatusItem('Notification Service', true, successColor),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusItem(String title, bool isOnline, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: darkColor,
            ),
          ),
        ),
        Text(
          isOnline ? 'Online' : 'Offline',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _generateReport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.assessment, color: warningColor),
              SizedBox(width: 8),
              Text('Generate Report'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select report type:'),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.route, color: infoColor),
                title: Text('Trips Report'),
                subtitle: Text('All trips with details'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _handleReportGeneration('trips', 'Trips Report');
                },
              ),
              ListTile(
                leading: Icon(Icons.directions_car, color: primaryColor),
                title: Text('Vehicles Report'),
                subtitle: Text('Vehicle status and information'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _handleReportGeneration('vehicles', 'Vehicles Report');
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: successColor),
                title: Text('Drivers Report'),
                subtitle: Text('Driver status and performance'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _handleReportGeneration('drivers', 'Drivers Report');
                },
                ),
              ],
            ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleReportGeneration(String reportType, String reportName) async {
    // إظهار شاشة التحميل
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: warningColor),
              SizedBox(height: 16),
              Text('Generating $reportName...'),
              SizedBox(height: 8),
              Text('Please wait...', style: TextStyle(color: Colors.grey)),
            ],
          ),
        );
      },
    );

    try {
      // محاولة إنشاء التقرير من الـ API
      final reportData = await ApiService.generateReport(reportType);
      
      // إغلاق شاشة التحميل
      Navigator.of(context).pop();
      
      if (reportData != null) {
        // إظهار التقرير
        _showReportResults(reportName, reportData);
      } else {
        // فشل في إنشاء التقرير، استخدم بيانات محلية
        await _generateFallbackReport(reportType, reportName);
      }
    } catch (e) {
      // إغلاق شاشة التحميل
      Navigator.of(context).pop();
      
      // فشل في إنشاء التقرير، استخدم بيانات محلية
      await _generateFallbackReport(reportType, reportName);
    }
  }

  Future<void> _generateFallbackReport(String reportType, String reportName) async {
    try {
      Map<String, dynamic> reportData = {};
      
      switch (reportType) {
        case 'trips':
          final trips = await ApiService.getTrips();
          reportData = {
            'totalTrips': trips.length,
            'completedTrips': trips.where((t) => t.status == 'Completed').length,
            'inProgressTrips': trips.where((t) => t.status == 'InProgress').length,
            'scheduledTrips': trips.where((t) => t.status == 'Scheduled').length,
            'trips': trips.take(5).map((t) => {
              'id': t.id,
              'startLocation': t.startLocation,
              'destination': t.destination,
              'status': t.status,
              'driverName': t.driverName ?? 'Unassigned',
              'vehicle': t.vehicleLicensePlate != null || t.vehicleModel != null 
                ? '${t.vehicleModel ?? 'Vehicle'} - ${t.vehicleLicensePlate ?? 'No Plate'}'
                : 'Unassigned',
            }).toList(),
          };
          break;
          
        case 'vehicles':
          final vehicles = await ApiService.getVehicles();
          reportData = {
            'totalVehicles': vehicles.length,
            'availableVehicles': vehicles.where((v) => v.status == 'available').length,
            'onTripVehicles': vehicles.where((v) => v.status == 'on_trip').length,
            'maintenanceVehicles': vehicles.where((v) => v.status?.contains('maintenance') == true).length,
            'vehicles': vehicles.take(5).map((v) => {
              'id': v.id,
              'model': v.model,
              'licensePlate': v.licensePlate,
              'status': v.status,
              'type': v.type,
            }).toList(),
          };
          break;
          
        case 'drivers':
          final drivers = await ApiService.getDrivers();
          reportData = {
            'totalDrivers': drivers.length,
            'availableDrivers': drivers.where((d) => d.driverStatus == 'Available').length,
            'onTripDrivers': drivers.where((d) => d.driverStatus == 'OnTrip').length,
            'notAvailableDrivers': drivers.where((d) => d.driverStatus == 'NotAvailable').length,
            'drivers': drivers.take(5).map((d) => {
              'id': d.id,
              'userName': d.userName,
              'email': d.email,
              'displayName': d.userName.isNotEmpty ? d.userName : d.email,
              'licenseNumber': d.licenseNumber ?? 'Not Available',
              'driverStatus': d.driverStatus,
            }).toList(),
          };
          break;
      }
      
      _showReportResults(reportName, reportData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Failed to generate report. Please try again.'),
          backgroundColor: dangerColor,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _showReportResults(String reportName, Map<String, dynamic> reportData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.analytics, color: warningColor),
              SizedBox(width: 8),
              Expanded(child: Text(reportName)),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReportSummary(reportData),
                  if (reportData.containsKey('trips') || 
                      reportData.containsKey('vehicles') || 
                      reportData.containsKey('drivers')) ...[
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 16),
                    Text('Recent Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    _buildReportDetails(reportData),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: warningColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Export', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('📄 Report export feature coming soon!'),
                    backgroundColor: infoColor,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportSummary(Map<String, dynamic> data) {
    List<Widget> summaryCards = [];
    
    data.forEach((key, value) {
      if (key.contains('total') || key.contains('Count') || key.contains('available') || 
          key.contains('completed') || key.contains('inProgress') || key.contains('scheduled') ||
          key.contains('onTrip') || key.contains('maintenance') || key.contains('notAvailable')) {
        Color cardColor = primaryColor;
        IconData cardIcon = Icons.info;
        
        if (key.contains('completed') || key.contains('available')) {
          cardColor = successColor;
          cardIcon = Icons.check_circle;
        } else if (key.contains('inProgress') || key.contains('onTrip')) {
          cardColor = infoColor;
          cardIcon = Icons.local_shipping;
        } else if (key.contains('scheduled')) {
          cardColor = warningColor;
          cardIcon = Icons.schedule;
        } else if (key.contains('maintenance')) {
          cardColor = dangerColor;
          cardIcon = Icons.build;
        }
        
        summaryCards.add(
          Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cardColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(cardIcon, color: cardColor, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    key.replaceAll(RegExp(r'([A-Z])'), ' \$1').trim(),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  value.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cardColor,
                  fontSize: 16,
                ),
              ),
              ],
            ),
          ),
        );
      }
    });
    
    return Column(children: summaryCards);
  }

  Widget _buildReportDetails(Map<String, dynamic> data) {
    if (data.containsKey('trips')) {
      return _buildTripsList(data['trips']);
    } else if (data.containsKey('vehicles')) {
      return _buildVehiclesList(data['vehicles']);
    } else if (data.containsKey('drivers')) {
      return _buildDriversList(data['drivers']);
    }
    return SizedBox.shrink();
  }

  Widget _buildTripsList(List<dynamic> trips) {
    return Column(
      children: trips.map<Widget>((trip) {
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(Icons.route, color: infoColor),
            title: Text('${trip['startLocation']} → ${trip['destination']}'),
            subtitle: Text('Driver: ${trip['driverName'] ?? 'Unassigned'}'),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(trip['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                trip['status'],
                style: TextStyle(color: _getStatusColor(trip['status']), fontSize: 12),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVehiclesList(List<dynamic> vehicles) {
    return Column(
      children: vehicles.map<Widget>((vehicle) {
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(Icons.directions_car, color: primaryColor),
            title: Text('${vehicle['model'] ?? 'Unknown Model'} - ${vehicle['licensePlate'] ?? 'No Plate'}'),
            subtitle: Text('Type: ${vehicle['type'] ?? 'Unknown Type'}'),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(vehicle['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                vehicle['status'] ?? 'Unknown',
                style: TextStyle(color: _getStatusColor(vehicle['status']), fontSize: 12),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDriversList(List<dynamic> drivers) {
    return Column(
      children: drivers.map<Widget>((driver) {
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(Icons.person, color: successColor),
            title: Text(driver['displayName'] ?? driver['userName'] ?? driver['email'] ?? 'Unknown Driver'),
            subtitle: Text('License: ${driver['licenseNumber']}'),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(driver['driverStatus']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getStatusDisplayName(driver['driverStatus'] ?? 'Available'),
                style: TextStyle(color: _getStatusColor(driver['driverStatus']), fontSize: 12),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
      case 'available':
        return successColor;
      case 'inprogress':
      case 'ontrip':
      case 'on_trip':
        return infoColor;
      case 'scheduled':
      case 'assignedonscheduledtrip':
        return warningColor;
      case 'cancelled':
      case 'notavailable':
      case 'need_maintenance':
      case 'under_maintenance':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  String _getStatusDisplayName(String status) {
    switch (status) {
      case 'Available': return 'Available';
      case 'OnTrip': return 'On Trip';
      case 'NotAvailable': return 'Not Available';
      case 'AssignedOnScheduledTrip': return 'Assigned On Trip';
      default: return status;
    }
  }


} 