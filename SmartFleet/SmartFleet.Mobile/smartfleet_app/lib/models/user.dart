class User {
  final String userId;
  final String userName;
  final String email;
  final List<String> roles;
  final String? profileImageUrl;
  final String token;
  final String expiresAt;

  User({
    required this.userId,
    required this.userName,
    required this.email,
    required this.roles,
    this.profileImageUrl,
    required this.token,
    required this.expiresAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'].toString(),
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      profileImageUrl: json['profileImageUrl'],
      token: json['token'] ?? '',
      expiresAt: json['expiresAt'] ?? '',
    );
  }

  // 3 أدوار فقط: Fleet Manager, Driver, User
  bool get isFleetManager => roles.contains('FleetManager');
  bool get isDriver => roles.contains('Driver');
  bool get isUser => roles.contains('NormalUser') || roles.contains('User') || 
                     roles.contains('commissioner') || roles.contains('SysSupport');
  
  String get primaryRole {
    if (isFleetManager) return 'Fleet Manager';
    if (isDriver) return 'Driver';
    return 'User';
  }
  
  // للتوافق مع الكود الحالي
  bool get isAdmin => isFleetManager;
} 