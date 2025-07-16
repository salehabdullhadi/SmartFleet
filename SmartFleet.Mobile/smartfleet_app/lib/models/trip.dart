class Trip {
  final int id;
  final String startLocation;
  final String destination;
  final String status;
  final DateTime? tripStartDate;
  final DateTime? tripEndDate;
  final double? distance;
  final String? vehicleId;
  final String? driverId;
  final String? driverName;
  final String? vehicleLicensePlate;
  final String? vehicleModel;
  final Order? order;

  Trip({
    required this.id,
    required this.startLocation,
    required this.destination,
    required this.status,
    this.tripStartDate,
    this.tripEndDate,
    this.distance,
    this.vehicleId,
    this.driverId,
    this.driverName,
    this.vehicleLicensePlate,
    this.vehicleModel,
    this.order,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? 0,
      startLocation: json['startLocation'] ?? '',
      destination: json['destination'] ?? '',
      status: json['status'] ?? '',
      tripStartDate: json['tripStartDate'] != null ? DateTime.parse(json['tripStartDate']) : null,
      tripEndDate: json['tripEndDate'] != null ? DateTime.parse(json['tripEndDate']) : null,
      distance: json['distance']?.toDouble(),
      vehicleId: json['vehicleId']?.toString(),
      driverId: json['driverId']?.toString(),
      driverName: json['driverName']?.toString(),
      vehicleLicensePlate: json['vehicleLicensePlate']?.toString(),
      vehicleModel: json['vehicleModel']?.toString(),
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
    );
  }
}

class Order {
  final int id;
  final String? reason;
  final int? passengerCount;
  final String? vehicleType;
  final String? status;
  final DateTime? createdAt;

  Order({
    required this.id,
    this.reason,
    this.passengerCount,
    this.vehicleType,
    this.status,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      reason: json['reason'],
      passengerCount: json['passengerCount'],
      vehicleType: json['vehicleType'],
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
} 