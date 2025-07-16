# 🗄️ مخطط قاعدة البيانات - SmartFleet

## 📋 نظرة عامة
قاعدة البيانات تستخدم **SQL Server** مع **Entity Framework Core**.

## 🏗️ الجداول الرئيسية

### 👤 Users (ApplicationUser)
```sql
- Id (string) - Primary Key
- UserName (string)
- Email (string)
- PhoneNumber (string)
- AccountStatus (bool)
- ProfileImageUrl (string)
- CreatedAt (DateTime)
```

### 🚗 Vehicles
```sql
- Id (int) - Primary Key
- Model (string)
- Type (enum: Car, Truck, Bus, Van, Motorcycle)
- Capacity (int)
- LicensePlate (string)
- Status (enum: available, need_maintenance, under_maintenance, on_trip)
- TotalDistanceTraveled (decimal)
- SimCardId (int?) - Foreign Key
- GeofenceId (int?) - Foreign Key
```

### 👨‍✈️ Drivers (extends ApplicationUser)
```sql
- LicenseNumber (string)
- LicenseExpiryDate (DateTime)
- DriverStatus (enum: Available, NotAvailable, OnTrip)
- DrowsinessCount (int)
```

### 🎯 Trips
```sql
- Id (int) - Primary Key
- VehicleId (int) - Foreign Key
- OrderId (int) - Foreign Key
- DriverId (string) - Foreign Key
- Distance (decimal)
- Status (enum: Scheduled, InProgress, Completed, Cancelled)
- CreatedAt (DateTime)
- CreatedBy (string) - Foreign Key
```

### 📋 Orders
```sql
- Id (int) - Primary Key
- UserId (string) - Foreign Key
- VehicleType (enum)
- PassengerCount (int)
- StartLocation (string)
- Destination (string)
- TripStartDate (DateTime)
- TripEndDate (DateTime)
- Reason (string)
- Status (enum: Pending, Approved, Cancelled, Rejected)
- CreatedAt (DateTime)
```

### 📍 VehicleLocations
```sql
- Id (int) - Primary Key
- VehicleId (int) - Foreign Key
- Latitude (decimal)
- Longitude (decimal)
- Speed (decimal)
- Timestamp (DateTime)
- DeviceId (string)
- DeviceModel (string)
```

### 🔔 Notifications
```sql
- Id (int) - Primary Key
- UserId (string) - Foreign Key
- Title (string)
- Message (string)
- RelatedTable (enum)
- RelatedId (int?)
- IsRead (bool)
- CreatedAt (DateTime)
```

### 🔧 Maintenances
```sql
- Id (int) - Primary Key
- VehicleId (int?) - Foreign Key
- ReportedBy (string) - Foreign Key
- IssueDescription (string)
- RepairStatus (enum: pending, in_progress, completed)
- Priority (enum: low, normal, high)
- CreatedAt (DateTime)
```

### 🗺️ Geofences
```sql
- Id (int) - Primary Key
- Name (string)
- Type (enum: Circle, Polygon)
- CenterLat (decimal)
- CenterLng (decimal)
- RadiusMeters (decimal)
- PolygonJson (string?)
- IsDefault (bool)
```

### 📱 SimCards
```sql
- Id (int) - Primary Key
- SimNumber (string)
- Carrier (string)
- Status (enum: Inactive, Active)
- CreatedAt (DateTime)
```

### 📊 Events
```sql
- Id (int) - Primary Key
- Type (enum: Create, Update, Delete, UserAction, SystemAlert)
- Severity (enum: info, warning, error)
- RelatedTable (enum)
- RelatedId (int)
- UserId (string?) - Foreign Key
- Message (string)
- CreatedAt (DateTime)
```

## 🔗 العلاقات الرئيسية

- **User → Orders** (1:Many)
- **Vehicle → Trips** (1:Many)
- **Trip → Order** (1:1)
- **Vehicle → VehicleLocations** (1:Many)
- **Vehicle → SimCard** (1:1)
- **Vehicle → Geofence** (Many:1)
- **User → Notifications** (1:Many)
- **User → Maintenances** (1:Many)

## 🚀 Migration Commands
```bash
# إنشاء migration جديد
dotnet ef migrations add MigrationName

# تطبيق migrations
dotnet ef database update

# حذف آخر migration
dotnet ef migrations remove
```

## 📊 الفهارس المقترحة
```sql
-- للبحث السريع
CREATE INDEX IX_Vehicles_LicensePlate ON Vehicles(LicensePlate);
CREATE INDEX IX_VehicleLocations_VehicleId_Timestamp ON VehicleLocations(VehicleId, Timestamp);
CREATE INDEX IX_Notifications_UserId_CreatedAt ON Notifications(UserId, CreatedAt);
``` 