class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  bool isRead;
  final DateTime createdAt;
  final String? userId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.userId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.now();
    if (json['createdAt'] != null) {
      try {
        // Parse the date string and handle timezone conversion
        String dateString = json['createdAt'];
        DateTime utcDate;
        
        if (dateString.endsWith('Z')) {
          // Already UTC format, parse directly then convert to local
          utcDate = DateTime.parse(dateString);
        } else {
          // Assume UTC if no timezone info and convert to local
          utcDate = DateTime.parse(dateString).toUtc();
        }
        
        parsedDate = utcDate.toLocal();
      } catch (e) {
        print('❌ Error parsing date: ${json['createdAt']}, using current time');
        parsedDate = DateTime.now();
      }
    }
    
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'No Title',
      message: json['message'] ?? 'No Message',
      type: json['type'] ?? 'info',
      isRead: json['isRead'] ?? false,
      createdAt: parsedDate,
      userId: json['userId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }
} 