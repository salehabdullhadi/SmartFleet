import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// SmartFleet App Theme
/// Consistent design system matching the backend color scheme
class AppTheme {
  AppTheme._();

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

  // Additional supporting colors
  static const Color surfaceColor = Colors.white;
  static const Color onSurfaceColor = darkColor;
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color shadowColor = Color(0x1A000000);

  // Text colors
  static const Color textPrimaryColor = darkColor;
  static const Color textSecondaryColor = Color(0xFF6B7280);
  static const Color textTertiaryColor = Color(0xFF9CA3AF);

  /// Light Theme Configuration
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: dangerColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: onSurfaceColor,
      onBackground: onSurfaceColor,
      onError: Colors.white,
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: darkColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        color: darkColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: primaryColor,
        size: 24,
      ),
    ),

    // Scaffold Theme
    scaffoldBackgroundColor: backgroundColor,

    // Card Theme
    cardTheme: CardTheme(
      color: surfaceColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
      shadowColor: shadowColor,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor, width: 1),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Icon Button Theme
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: primaryColor,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: CircleBorder(),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: dangerColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: dangerColor, width: 2),
      ),
      labelStyle: TextStyle(
        color: textSecondaryColor,
        fontSize: 16,
      ),
      hintStyle: TextStyle(
        color: textTertiaryColor,
        fontSize: 16,
      ),
      prefixIconColor: primaryColor,
      suffixIconColor: primaryColor,
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return textTertiaryColor;
      }),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor.withOpacity(0.5);
        }
        return textTertiaryColor.withOpacity(0.3);
      }),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColor,
      linearTrackColor: primaryColor.withOpacity(0.2),
      circularTrackColor: primaryColor.withOpacity(0.2),
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: primaryColor,
      unselectedLabelColor: textSecondaryColor,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: textSecondaryColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Navigation Rail Theme
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: surfaceColor,
      selectedIconTheme: IconThemeData(color: primaryColor),
      unselectedIconTheme: IconThemeData(color: textSecondaryColor),
      selectedLabelTextStyle: TextStyle(color: primaryColor),
      unselectedLabelTextStyle: TextStyle(color: textSecondaryColor),
    ),

    // Drawer Theme
    drawerTheme: DrawerThemeData(
      backgroundColor: surfaceColor,
      elevation: 16,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      selectedTileColor: primaryColor.withOpacity(0.1),
      selectedColor: primaryColor,
      iconColor: textSecondaryColor,
      textColor: textPrimaryColor,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: dividerColor,
      thickness: 1,
      space: 1,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: lightColor,
      deleteIconColor: textSecondaryColor,
      disabledColor: lightColor.withOpacity(0.5),
      selectedColor: primaryColor.withOpacity(0.2),
      secondarySelectedColor: secondaryColor.withOpacity(0.2),
      labelPadding: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: TextStyle(
        color: textPrimaryColor,
        fontSize: 14,
      ),
      secondaryLabelStyle: TextStyle(
        color: textPrimaryColor,
        fontSize: 14,
      ),
      brightness: Brightness.light,
    ),

    // Snack Bar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: darkColor,
      contentTextStyle: TextStyle(color: Colors.white),
      actionTextColor: primaryColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textPrimaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textSecondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: textTertiaryColor,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(
      color: textSecondaryColor,
      size: 24,
    ),
  );

  /// Helper method to create status color
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'done':
      case 'finished':
        return successColor;
      case 'in_progress':
      case 'active':
      case 'running':
        return infoColor;
      case 'pending':
      case 'waiting':
        return warningColor;
      case 'cancelled':
      case 'failed':
      case 'error':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  /// Helper method to create gradient
  static LinearGradient createGradient({
    required Color startColor,
    required Color endColor,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      colors: [startColor, endColor],
      begin: begin,
      end: end,
    );
  }

  /// Primary gradient
  static LinearGradient get primaryGradient => createGradient(
        startColor: primaryColor,
        endColor: secondaryColor,
      );

  /// Success gradient
  static LinearGradient get successGradient => createGradient(
        startColor: successColor,
        endColor: successColor.withOpacity(0.8),
      );

  /// Warning gradient
  static LinearGradient get warningGradient => createGradient(
        startColor: warningColor,
        endColor: warningColor.withOpacity(0.8),
      );

  /// Danger gradient
  static LinearGradient get dangerGradient => createGradient(
        startColor: dangerColor,
        endColor: dangerColor.withOpacity(0.8),
      );

  /// Helper method to create shadow
  static List<BoxShadow> createShadow({
    Color? color,
    double blurRadius = 10,
    Offset offset = const Offset(0, 4),
    double spreadRadius = 0,
  }) {
    return [
      BoxShadow(
        color: color ?? shadowColor,
        blurRadius: blurRadius,
        offset: offset,
        spreadRadius: spreadRadius,
      ),
    ];
  }

  /// Card shadow
  static List<BoxShadow> get cardShadow => createShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: Offset(0, 4),
      );

  /// Elevated shadow
  static List<BoxShadow> get elevatedShadow => createShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: Offset(0, 8),
      );

  /// Floating shadow
  static List<BoxShadow> get floatingShadow => createShadow(
        color: primaryColor.withOpacity(0.3),
        blurRadius: 20,
        offset: Offset(0, 10),
      );
}

/// Extension methods for Theme customization
extension ThemeExtension on ThemeData {
  /// Get primary color
  Color get primaryColor => AppTheme.primaryColor;

  /// Get secondary color
  Color get secondaryColor => AppTheme.secondaryColor;

  /// Get success color
  Color get successColor => AppTheme.successColor;

  /// Get danger color
  Color get dangerColor => AppTheme.dangerColor;

  /// Get warning color
  Color get warningColor => AppTheme.warningColor;

  /// Get info color
  Color get infoColor => AppTheme.infoColor;

  /// Get background color
  Color get backgroundColor => AppTheme.backgroundColor;
} 