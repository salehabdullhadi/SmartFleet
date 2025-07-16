import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../services/api_service.dart';
import '../models/trip.dart';
import '../widgets/loading_widget.dart';

class TripsScreen extends StatefulWidget {
  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> with TickerProviderStateMixin {
  List<Trip> _trips = [];
  bool _isLoading = true;
  String? _errorMessage;
  late AnimationController _refreshAnimationController;

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

  @override
  void initState() {
    super.initState();
    _refreshAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _loadTrips();
  }

  @override
  void dispose() {
    _refreshAnimationController.dispose();
    super.dispose();
  }

  Future<void> _loadTrips() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final trips = await ApiService.getTrips();
      
      if (mounted) {
        setState(() {
          _trips = trips;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Error loading trips: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load trips. Please try again.';
          _isLoading = false;
        });
      }
    }
  }

  void _refreshTrips() {
    _refreshAnimationController.forward().then((_) {
      _refreshAnimationController.reset();
    });
    _loadTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'Trips',
        style: TextStyle(
          color: darkColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.arrow_back, color: primaryColor),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        AnimatedBuilder(
          animation: _refreshAnimationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _refreshAnimationController.value * 2 * 3.14159,
              child: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.refresh, color: primaryColor),
                ),
                onPressed: _refreshTrips,
              ),
            );
          },
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    if (_trips.isEmpty) {
      return _buildEmptyState();
    }

    return _buildTripsList();
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
            'Loading trips...',
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

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: AnimationConfiguration.staggeredList(
          position: 0,
          duration: Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 50,
            child: FadeInAnimation(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: dangerColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.error_outline,
                        color: dangerColor,
                        size: 48,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Oops! Something went wrong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      _errorMessage!,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkColor.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _refreshTrips,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(Icons.refresh),
                      label: Text(
                        'Try Again',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: AnimationConfiguration.staggeredList(
          position: 0,
          duration: Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 50,
            child: FadeInAnimation(
              child: Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: infoColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.route,
                        color: infoColor,
                        size: 64,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'No Trips Found',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: darkColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'There are no trips to display at the moment.',
                      style: TextStyle(
                        fontSize: 16,
                        color: darkColor.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _refreshTrips,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(Icons.refresh),
                      label: Text(
                        'Refresh',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripsList() {
    return RefreshIndicator(
      onRefresh: _loadTrips,
      color: primaryColor,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: AnimationLimiter(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _trips.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: _buildTripCard(_trips[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard(Trip trip) {
    Color statusColor = _getStatusColor(trip.status);
    IconData statusIcon = _getStatusIcon(trip.status);

    return InkWell(
      onTap: () => _showTripDetails(trip),
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
          border: Border.all(
            color: statusColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    statusIcon,
                    color: statusColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trip #${trip.id}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          trip.status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: darkColor.withOpacity(0.3),
                  size: 16,
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
                         // Route information
             _buildRouteInfo('From', trip.startLocation, Icons.location_on, successColor),
             SizedBox(height: 8),
             _buildRouteInfo('To', trip.destination, Icons.flag, dangerColor),
            
            SizedBox(height: 16),
            
                         // Trip details
             Row(
               children: [
                 Expanded(
                   child: _buildDetailChip(
                     'Driver',
                     trip.driverName ?? 'Unassigned',
                     Icons.person,
                     primaryColor,
                   ),
                 ),
                 SizedBox(width: 12),
                 Expanded(
                   child: _buildDetailChip(
                     'Vehicle',
                     trip.vehicleLicensePlate ?? trip.vehicleModel ?? 'Unassigned',
                     Icons.directions_car,
                     infoColor,
                   ),
                 ),
               ],
             ),
             
             if (trip.distance != null) ...[
               SizedBox(height: 12),
               Row(
                 children: [
                   Expanded(
                     child: _buildDetailChip(
                       'Distance',
                       '${trip.distance!.toStringAsFixed(1)} km',
                       Icons.straighten,
                       warningColor,
                     ),
                   ),
                   SizedBox(width: 12),
                   Expanded(
                     child: _buildDetailChip(
                       'Status',
                       trip.status,
                       Icons.info,
                       _getStatusColor(trip.status),
                     ),
                   ),
                 ],
               ),
             ],
          ],
        ),
      ),
    );
  }

  Widget _buildRouteInfo(String label, String location, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: darkColor.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                location,
                style: TextStyle(
                  fontSize: 14,
                  color: darkColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailChip(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: darkColor.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: darkColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
      case 'active':
        return infoColor;
      case 'pending':
        return warningColor;
      case 'cancelled':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.check_circle;
      case 'in_progress':
      case 'active':
        return Icons.directions_car;
      case 'pending':
        return Icons.schedule;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.route;
    }
  }

  void _showTripDetails(Trip trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: darkColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.route,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Trip Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: darkColor,
                              ),
                            ),
                            Text(
                              'Trip #${trip.id}',
                              style: TextStyle(
                                fontSize: 14,
                                color: darkColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: darkColor),
                      ),
                    ],
                  ),
                ),
                
                Divider(height: 1),
                
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _getStatusColor(trip.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getStatusIcon(trip.status),
                                color: _getStatusColor(trip.status),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Status: ${trip.status}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(trip.status),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 24),
                        
                        // Route details
                        Text(
                          'Route Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkColor,
                          ),
                        ),
                                                 SizedBox(height: 16),
                         _buildDetailRow('Start Location', trip.startLocation, Icons.location_on),
                         SizedBox(height: 12),
                         _buildDetailRow('End Location', trip.destination, Icons.flag),
                         
                         if (trip.driverName != null || trip.vehicleLicensePlate != null || trip.vehicleModel != null) ...[
                           SizedBox(height: 24),
                           Text(
                             'Assignment Details',
                             style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                               color: darkColor,
                             ),
                           ),
                           SizedBox(height: 16),
                           if (trip.driverName != null)
                             _buildDetailRow('Assigned Driver', trip.driverName!, Icons.person),
                           if (trip.driverName != null && (trip.vehicleLicensePlate != null || trip.vehicleModel != null))
                             SizedBox(height: 12),
                           if (trip.vehicleLicensePlate != null || trip.vehicleModel != null)
                             _buildDetailRow('Assigned Vehicle', 
                               '${trip.vehicleModel ?? 'Vehicle'} (${trip.vehicleLicensePlate ?? 'No Plate'})', 
                               Icons.directions_car),
                         ],
                         
                         if (trip.distance != null || trip.tripStartDate != null) ...[
                           SizedBox(height: 24),
                           Text(
                             'Trip Details',
                             style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                               color: darkColor,
                             ),
                           ),
                           SizedBox(height: 16),
                           if (trip.distance != null)
                             _buildDetailRow('Distance', '${trip.distance!.toStringAsFixed(1)} km', Icons.straighten),
                           if (trip.distance != null && trip.tripStartDate != null)
                             SizedBox(height: 12),
                           if (trip.tripStartDate != null)
                             _buildDetailRow('Start Date', trip.tripStartDate!.toString().substring(0, 16), Icons.schedule),
                         ],
                        
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: darkColor.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _refreshTrips,
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 8,
      child: Icon(Icons.refresh),
    );
  }
} 