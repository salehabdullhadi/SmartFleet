class Vehicle {
  final int id;
  final String licensePlate;
  final String model;
  final String type;
  final String status;
  final int? capacity;
  final String? vehicleImageUrl;
  final double? totalDistanceTraveled;

  Vehicle({
    required this.id,
    required this.licensePlate,
    required this.model,
    required this.type,
    required this.status,
    this.capacity,
    this.vehicleImageUrl,
    this.totalDistanceTraveled,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] ?? 0,
      licensePlate: json['licensePlate'] ?? '',
      model: json['model'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      capacity: json['capacity'],
      vehicleImageUrl: json['vehicleImageUrl'],
      totalDistanceTraveled: json['totalDistanceTraveled']?.toDouble(),
    );
  }
} 