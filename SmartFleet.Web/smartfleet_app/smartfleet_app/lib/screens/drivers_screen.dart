import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/driver.dart';
import '../widgets/loading_widget.dart';

class DriversScreen extends StatefulWidget {
  @override
  _DriversScreenState createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {
  List<Driver> _drivers = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDrivers();
  }

  Future<void> _loadDrivers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final drivers = await ApiService.getDrivers();
      setState(() {
        _drivers = drivers;
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
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Fleet Drivers',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF2E3A7A),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadDrivers,
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
                        'Error loading drivers',
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
                        onPressed: _loadDrivers,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2E3A7A),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadDrivers,
                  child: _drivers.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: _drivers.length,
                          itemBuilder: (context, index) {
                            final driver = _drivers[index];
                            return _buildDriverCard(driver);
                          },
                        ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            'No drivers found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Fleet drivers will appear here once available',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(Driver driver) {
    Color statusColor = _getStatusColor(driver.driverStatus);
    IconData statusIcon = _getStatusIcon(driver.driverStatus);
    
    // Check if license is expiring soon
    bool isLicenseExpiringSoon = false;
    int daysUntilExpiry = 0;
    if (driver.licenseExpiryDate != null) {
      final now = DateTime.now();
      final expiryDate = driver.licenseExpiryDate!;
      daysUntilExpiry = expiryDate.difference(now).inDays;
      isLicenseExpiringSoon = daysUntilExpiry <= 30 && daysUntilExpiry >= 0;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar and status
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.purple.withOpacity(0.1),
                backgroundImage: driver.profileImageUrl != null && driver.profileImageUrl!.startsWith('http')
                    ? NetworkImage(driver.profileImageUrl!)
                    : null,
                child: driver.profileImageUrl == null || !driver.profileImageUrl!.startsWith('http')
                    ? Icon(Icons.person, color: Colors.purple, size: 24)
                    : null,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver.userName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E3A7A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      driver.email,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 14),
                    SizedBox(width: 4),
                    Text(
                      driver.driverStatus,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 12),

          // License warning if expiring soon
          if (isLicenseExpiringSoon) ...[
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'License expires in $daysUntilExpiry days',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
          ],

          // Driver details grid
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                if (driver.licenseNumber != null) ...[
                  _buildDetailRow('License Number', driver.licenseNumber!),
                  SizedBox(height: 8),
                ],

                if (driver.licenseExpiryDate != null) ...[
                  _buildDetailRow(
                    'License Expiry', 
                    _formatDate(driver.licenseExpiryDate!),
                    isWarning: isLicenseExpiringSoon,
                  ),
                  SizedBox(height: 8),
                ],

                if (driver.email != driver.userName)
                  _buildDetailRow('Email', driver.email),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isWarning = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: isWarning ? Colors.orange.shade700 : Color(0xFF2E3A7A),
              fontWeight: isWarning ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
      case 'active':
        return Colors.green;
      case 'busy':
      case 'driving':
        return Colors.blue;
      case 'offline':
      case 'break':
        return Colors.orange;
      case 'inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'available':
      case 'active':
        return Icons.check_circle;
      case 'busy':
      case 'driving':
        return Icons.directions_car;
      case 'offline':
      case 'break':
        return Icons.pause_circle;
      case 'inactive':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
} 