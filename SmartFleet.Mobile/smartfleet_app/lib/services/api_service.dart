import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/trip.dart';
import '../models/notification.dart';
import '../models/vehicle.dart';
import '../models/driver.dart';
import '../config/api_config.dart';
import 'auth_service.dart';

class ApiService {
  static String get baseUrl => ApiConfig.baseUrl;

  static Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (AuthService.token != null) {
      headers['Authorization'] = 'Bearer ${AuthService.token}';
      print('🔐 Adding JWT token to headers: ${AuthService.token!.substring(0, 30)}...');
    } else {
      print('⚠️ No JWT token available for API call');
    }

    return headers;
  }

  // Dashboard counts
  static Future<Map<String, int>> getDashboardCounts() async {
    try {
      print('🔄 Fetching dashboard counts from Real API...');
      
      final user = AuthService.currentUser;
      if (user == null) return {'trips': 0, 'orders': 0, 'vehicles': 0, 'drivers': 0, 'notifications': 0};

      final futures = <Future<int>>[];
      
      // Get trips count
      futures.add(_getCount('/api/tripsapi'));
      
      // Get counts based on user role
      if (user.isFleetManager) {
        // Fleet Manager sees everything
        futures.add(_getCount('/api/ordersapi'));
        futures.add(_getCount('/api/vehiclesapi'));
        futures.add(_getCount('/api/driversapi'));
      } else if (user.isUser) {
        // User sees orders and trips only
        futures.add(_getCount('/api/ordersapi'));
        futures.add(Future.value(0)); // vehicles
        futures.add(Future.value(0)); // drivers
      } else {
        // Driver sees only trips
        futures.addAll([
          Future.value(0), // orders
          Future.value(0), // vehicles  
          Future.value(0), // drivers
        ]);
      }
      
      // Get notifications count
      futures.add(_getCount('/api/notificationsapi'));

      final results = await Future.wait(futures);
      
      final counts = {
        'trips': results[0],
        'orders': results[1],
        'vehicles': results[2],
        'drivers': results[3],
        'notifications': results[4],
      };

      print('✅ Dashboard counts: $counts');
      return counts;
    } catch (e) {
      print('❌ Error fetching dashboard counts: $e');
      return {'trips': 0, 'orders': 0, 'vehicles': 0, 'drivers': 0, 'notifications': 0};
    }
  }

  static Future<int> _getCount(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final responseData = data['data'];
          if (responseData is Map) {
            // Get count from the appropriate field
            if (responseData.containsKey('trips')) return (responseData['trips'] as List).length;
            if (responseData.containsKey('orders')) return (responseData['orders'] as List).length;
            if (responseData.containsKey('vehicles')) return (responseData['vehicles'] as List).length;
            if (responseData.containsKey('drivers')) return (responseData['drivers'] as List).length;
            if (responseData.containsKey('notifications')) return (responseData['notifications'] as List).length;
          }
        }
      }
      return 0;
    } catch (e) {
      print('❌ Error getting count for $endpoint: $e');
      return 0;
    }
  }

  // Get Trips
  static Future<List<Trip>> getTrips() async {
    try {
      print('🔄 Fetching trips from Real API...');
      
      final response = await http.get(
        Uri.parse('$baseUrl/api/tripsapi'),
        headers: _getHeaders(),
      );

      print('📡 Trips Response: ${response.statusCode}');
      print('📋 Trips Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final tripsData = data['data']['trips'] as List;
          final trips = tripsData.map((json) => Trip.fromJson(json)).toList();
          print('✅ Loaded ${trips.length} trips from API');
          return trips;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
      return [];
    } catch (e) {
      print('❌ Error fetching trips: $e');
      return [];
    }
  }

  // Get Orders (Fleet Manager only)
  static Future<List<Order>> getOrders() async {
    try {
      print('🔄 Fetching orders from Real API...');
      
      final response = await http.get(
        Uri.parse('$baseUrl/api/ordersapi'),
        headers: _getHeaders(),
      );

      print('📡 Orders Response: ${response.statusCode}');
      print('📋 Orders Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final ordersData = data['data']['orders'] as List;
          final orders = ordersData.map((json) => Order.fromJson(json)).toList();
          print('✅ Loaded ${orders.length} orders from API');
          return orders;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
      return [];
    } catch (e) {
      print('❌ Error fetching orders: $e');
      return [];
    }
  }

  // Get Vehicles (Fleet Manager only)
  static Future<List<Vehicle>> getVehicles() async {
    try {
      print('🔄 Fetching vehicles from Real API...');
      
      final response = await http.get(
        Uri.parse('$baseUrl/api/vehiclesapi'),
        headers: _getHeaders(),
      );

      print('📡 Vehicles Response: ${response.statusCode}');
      print('📋 Vehicles Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final vehiclesData = data['data']['vehicles'] as List;
          final vehicles = vehiclesData.map((json) => Vehicle.fromJson(json)).toList();
          print('✅ Loaded ${vehicles.length} vehicles from API');
          return vehicles;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
      return [];
    } catch (e) {
      print('❌ Error fetching vehicles: $e');
      return [];
    }
  }

  // Get Drivers (Fleet Manager only)
  static Future<List<Driver>> getDrivers() async {
    try {
      print('🔄 Fetching drivers from Real API...');
      
      final response = await http.get(
        Uri.parse('$baseUrl/api/driversapi'),
        headers: _getHeaders(),
      );

      print('📡 Drivers Response: ${response.statusCode}');
      print('📋 Drivers Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final driversData = data['data']['drivers'] as List;
          final drivers = driversData.map((json) => Driver.fromJson(json)).toList();
          print('✅ Loaded ${drivers.length} drivers from API');
          return drivers;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
      return [];
    } catch (e) {
      print('❌ Error fetching drivers: $e');
      return [];
    }
  }

  // Get Notifications
  static Future<List<NotificationModel>> getNotifications() async {
    try {
      print('🔄 Fetching notifications from Real API...');
      
      final response = await http.get(
        Uri.parse('$baseUrl/api/notificationsapi'),
        headers: _getHeaders(),
      );

      print('📡 Notifications Response: ${response.statusCode}');
      print('📋 Notifications Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final notificationsData = data['data']['notifications'] as List;
          final notifications = notificationsData.map((json) => NotificationModel.fromJson(json)).toList();
          print('✅ Loaded ${notifications.length} notifications from API');
          return notifications;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
      return [];
    } catch (e) {
      print('❌ Error fetching notifications: $e');
      return [];
    }
  }
  

  // Update Driver Status
  static Future<bool> updateDriverStatus(String status) async {
    try {
      print('🔄 Updating driver status to: $status');
      
      final user = AuthService.currentUser;
      if (user == null || !user.isDriver) {
        print('⚠️ User is not a driver');
        return false;
      }

      final response = await http.put(
        Uri.parse('$baseUrl/api/driversapi/status'),
        headers: _getHeaders(),
        body: json.encode({
          'status': status,
        }),
      );

      print('📡 Update Status Response: ${response.statusCode}');
      print('📋 Update Status Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          print('✅ Driver status updated successfully');
          return true;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
      return false;
    } catch (e) {
      print('❌ Error updating driver status: $e');
      return false;
    }
  }



  // Create Order (for regular users)
  static Future<bool> createOrder(Map<String, dynamic> orderData) async {
    try {
      print('🔄 Creating new order...');
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/ordersapi'),
        headers: _getHeaders(),
        body: json.encode(orderData),
      );

      print('📡 Create Order Response: ${response.statusCode}');
      print('📋 Create Order Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          print('✅ Order created successfully');
          return true;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
      return false;
    } catch (e) {
      print('❌ Error creating order: $e');
      return false;
    }
  }

  // Generate Report (for fleet managers)
  static Future<Map<String, dynamic>?> generateReport(String reportType) async {
    try {
      print('🔄 Generating $reportType report...');
      
      final response = await http.get(
        Uri.parse('$baseUrl/api/reports/$reportType'),
        headers: _getHeaders(),
      );

      print('📡 Generate Report Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          print('✅ Report generated successfully');
          return data['data'];
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
      return null;
    } catch (e) {
      print('❌ Error generating report: $e');
      return null;
    }
  }

  static void setToken(String token) {
    // This method exists for compatibility but we use AuthService.token directly
  }
  
  static void clearToken() {
    // This method exists for compatibility but we use AuthService.logout() directly
  }
} 