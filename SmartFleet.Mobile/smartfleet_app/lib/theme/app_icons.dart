import 'package:flutter/material.dart';

/// SmartFleet Custom Icons
/// Collection of beautiful icons that match our design system
class AppIcons {
  AppIcons._();

  // Vehicle Icons
  static const IconData car = Icons.directions_car;
  static const IconData carOutlined = Icons.directions_car_outlined;
  static const IconData truck = Icons.local_shipping;
  static const IconData bus = Icons.directions_bus;
  static const IconData motorcycle = Icons.motorcycle;

  // Trip & Route Icons
  static const IconData route = Icons.route;
  static const IconData routeOutlined = Icons.route_outlined;
  static const IconData location = Icons.location_on;
  static const IconData locationOutlined = Icons.location_on_outlined;
  static const IconData flag = Icons.flag;
  static const IconData flagOutlined = Icons.flag_outlined;
  static const IconData navigation = Icons.navigation;
  static const IconData straighten = Icons.straighten;

  // Driver & User Icons
  static const IconData person = Icons.person;
  static const IconData personOutlined = Icons.person_outlined;
  static const IconData badge = Icons.badge;
  static const IconData contactCard = Icons.contact_page;
  static const IconData drivingLicense = Icons.credit_card;

  // Order & Document Icons
  static const IconData description = Icons.description;
  static const IconData descriptionOutlined = Icons.description_outlined;
  static const IconData receipt = Icons.receipt;
  static const IconData assignment = Icons.assignment;
  static const IconData folder = Icons.folder;

  // Status Icons
  static const IconData checkCircle = Icons.check_circle;
  static const IconData checkCircleOutlined = Icons.check_circle_outlined;
  static const IconData schedule = Icons.schedule;
  static const IconData pending = Icons.pending;
  static const IconData cancel = Icons.cancel;
  static const IconData error = Icons.error;
  static const IconData warning = Icons.warning;
  static const IconData info = Icons.info;

  // Navigation Icons
  static const IconData dashboard = Icons.dashboard;
  static const IconData dashboardOutlined = Icons.dashboard_outlined;
  static const IconData menu = Icons.menu;
  static const IconData back = Icons.arrow_back;
  static const IconData forward = Icons.arrow_forward;
  static const IconData up = Icons.keyboard_arrow_up;
  static const IconData down = Icons.keyboard_arrow_down;

  // Action Icons
  static const IconData refresh = Icons.refresh;
  static const IconData add = Icons.add;
  static const IconData edit = Icons.edit;
  static const IconData delete = Icons.delete;
  static const IconData save = Icons.save;
  static const IconData search = Icons.search;
  static const IconData filter = Icons.filter_list;
  static const IconData sort = Icons.sort;

  // Communication Icons
  static const IconData notifications = Icons.notifications;
  static const IconData notificationsOutlined = Icons.notifications_outlined;
  static const IconData notificationsActive = Icons.notifications_active;
  static const IconData notificationsOff = Icons.notifications_off;
  static const IconData message = Icons.message;
  static const IconData call = Icons.call;
  static const IconData email = Icons.email;

  // Time & Date Icons
  static const IconData dateRange = Icons.date_range;
  static const IconData accessTime = Icons.access_time;
  static const IconData timerOutlined = Icons.timer_outlined;
  static const IconData history = Icons.history;

  // Settings & Configuration Icons
  static const IconData settings = Icons.settings;
  static const IconData tune = Icons.tune;
  static const IconData build = Icons.build;
  static const IconData wrench = Icons.handyman;

  // Security Icons
  static const IconData lock = Icons.lock;
  static const IconData lockOutlined = Icons.lock_outlined;
  static const IconData lockOpen = Icons.lock_open;
  static const IconData key = Icons.vpn_key;
  static const IconData security = Icons.security;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;

  // System Icons
  static const IconData cloudDone = Icons.cloud_done;
  static const IconData wifiOff = Icons.wifi_off;
  static const IconData signalWifi4Bar = Icons.signal_wifi_4_bar;
  static const IconData bluetooth = Icons.bluetooth;
  static const IconData gps = Icons.gps_fixed;

  // Analytics & Reports Icons
  static const IconData analytics = Icons.analytics;
  static const IconData assessment = Icons.assessment;
  static const IconData chartBar = Icons.bar_chart;
  static const IconData chartLine = Icons.show_chart;
  static const IconData pieChart = Icons.pie_chart;

  // Maintenance Icons
  static const IconData buildTool = Icons.build;
  static const IconData tools = Icons.handyman;
  static const IconData engineeringOutlined = Icons.engineering_outlined;
  static const IconData carRepair = Icons.car_repair;

  // Geofence Icons
  static const IconData mapMarker = Icons.place;
  static const IconData mapMarkerOutlined = Icons.place_outlined;
  static const IconData boundaryBox = Icons.crop_free;
  static const IconData fence = Icons.fence;

  // Connection & Sync Icons
  static const IconData sync = Icons.sync;
  static const IconData syncProblem = Icons.sync_problem;
  static const IconData cloud = Icons.cloud;
  static const IconData cloudOff = Icons.cloud_off;

  // File & Media Icons
  static const IconData image = Icons.image;
  static const IconData fileDownload = Icons.file_download;
  static const IconData fileUpload = Icons.file_upload;
  static const IconData attachment = Icons.attach_file;

  // Custom Widget for Animated Icons
  static Widget animatedIcon({
    required IconData icon,
    required Color color,
    double size = 24.0,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedContainer(
      duration: duration,
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }

  // Custom Widget for Status Icon with Color
  static Widget statusIcon({
    required String status,
    double size = 20.0,
  }) {
    IconData icon;
    Color color;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'done':
      case 'finished':
        icon = checkCircle;
        color = const Color(0xFF198754); // Success Green
        break;
      case 'in_progress':
      case 'active':
      case 'running':
        icon = car;
        color = const Color(0xFF0DCAF0); // Info Blue
        break;
      case 'pending':
      case 'waiting':
        icon = schedule;
        color = const Color(0xFFFFC107); // Warning Yellow
        break;
      case 'cancelled':
      case 'failed':
      case 'error':
        icon = cancel;
        color = const Color(0xFFDC3545); // Danger Red
        break;
      default:
        icon = info;
        color = const Color(0xFF20B2AA); // Primary Teal
    }

    return Icon(
      icon,
      color: color,
      size: size,
    );
  }

  // Custom Widget for Vehicle Type Icon
  static Widget vehicleTypeIcon({
    required String vehicleType,
    double size = 24.0,
    Color? color,
  }) {
    IconData icon;
    
    switch (vehicleType.toLowerCase()) {
      case 'car':
      case 'sedan':
      case 'hatchback':
        icon = car;
        break;
      case 'truck':
      case 'pickup':
      case 'cargo':
        icon = truck;
        break;
      case 'bus':
      case 'minibus':
        icon = bus;
        break;
      case 'motorcycle':
      case 'bike':
        icon = motorcycle;
        break;
      default:
        icon = car;
    }

    return Icon(
      icon,
      color: color ?? const Color(0xFF20B2AA),
      size: size,
    );
  }

  // Custom Widget for Connection Status Icon
  static Widget connectionStatusIcon({
    required bool isConnected,
    double size = 20.0,
  }) {
    return Icon(
      isConnected ? cloudDone : cloudOff,
      color: isConnected 
        ? const Color(0xFF198754) // Success Green
        : const Color(0xFF6C757D), // Secondary Gray
      size: size,
    );
  }

  // Custom Widget for Notification Icon with Badge
  static Widget notificationIcon({
    required int count,
    double size = 24.0,
    Color? color,
  }) {
    return Stack(
      children: [
        Icon(
          count > 0 ? notificationsActive : notificationsOutlined,
          color: color ?? const Color(0xFF20B2AA),
          size: size,
        ),
        if (count > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFFDC3545), // Danger Red
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                count > 99 ? '99+' : count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

/// Helper class for creating consistent icon themes
class AppIconThemes {
  static const Color primaryColor = Color(0xFF20B2AA);
  static const Color secondaryColor = Color(0xFF17A2B8);
  static const Color successColor = Color(0xFF198754);
  static const Color dangerColor = Color(0xFFDC3545);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF0DCAF0);
  static const Color lightColor = Color(0xFF6C757D);
  static const Color darkColor = Color(0xFF212529);

  // Icon button theme
  static ButtonStyle iconButtonStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    double? size,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? primaryColor.withOpacity(0.1),
      foregroundColor: foregroundColor ?? primaryColor,
      elevation: 0,
      padding: EdgeInsets.all(size ?? 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  // Floating action button theme
  static FloatingActionButtonThemeData fabTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: CircleBorder(),
    );
  }
} 