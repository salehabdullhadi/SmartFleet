class Driver {
  final String id;
  final String userName;
  final String email;
  final String? licenseNumber;
  final DateTime? licenseExpiryDate;
  final String driverStatus;
  final String? profileImageUrl;

  Driver({
    required this.id,
    required this.userName,
    required this.email,
    this.licenseNumber,
    this.licenseExpiryDate,
    required this.driverStatus,
    this.profileImageUrl,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id']?.toString() ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      licenseNumber: json['licenseNumber'],
      licenseExpiryDate: json['licenseExpiryDate'] != null ? DateTime.parse(json['licenseExpiryDate']) : null,
      driverStatus: json['driverStatus'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }
} 