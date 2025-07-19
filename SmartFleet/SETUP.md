# 🛠️ دليل الإعداد والتشغيل - SmartFleet

## 📋 المتطلبات الأساسية

### 💻 للنظام الخلفي (Backend):
- **.NET 8.0 SDK** - [تحميل](https://dotnet.microsoft.com/download/dotnet/8.0)
- **SQL Server 2019+** - [تحميل](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
- **Visual Studio 2022** أو **VS Code** - [تحميل](https://visualstudio.microsoft.com/)
- **Git** - [تحميل](https://git-scm.com/)

### 📱 للتطبيق المحمول (Flutter):
- **Flutter 3.0+** - [تحميل](https://flutter.dev/docs/get-started/install)
- **Dart 3.0+** - يأتي مع Flutter
- **Android Studio** - [تحميل](https://developer.android.com/studio)
- **VS Code** مع إضافة Flutter - [تحميل](https://code.visualstudio.com/)

### 🔧 للنظام المدمج (Arduino):
- **Arduino IDE** - [تحميل](https://www.arduino.cc/en/software)
- **SIM808 Module** - [شراء](https://www.amazon.com/SIM808-Module-GSM-GPRS-GPS/dp/B01H3HQCDY)
- **شريحة SIM** مع بيانات
- **لوحة Arduino** (UNO/Nano/ESP32)

---

## 🚀 خطوات التشغيل

### 1️⃣ تحميل المشروع

```bash
# استنساخ المشروع
git clone https://github.com/your-username/SmartFleet.git

# الانتقال للمجلد
cd SmartFleet
```

### 2️⃣ إعداد قاعدة البيانات

#### أ. إنشاء قاعدة البيانات:
1. افتح **SQL Server Management Studio**
2. أنشئ قاعدة بيانات جديدة:
```sql
CREATE DATABASE SmartFleetdata4;
```

#### ب. تحديث Connection String:
افتح ملف `SmartFleet.Web/appsettings.json` وحدث:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=YOUR_SERVER;Database=SmartFleetdata4;Integrated Security=True;TrustServerCertificate=True;"
  }
}
```

### 3️⃣ تشغيل النظام الخلفي

```bash
# الانتقال لمجلد الباك إند
cd SmartFleet.Web

# استعادة الحزم
dotnet restore

# تطبيق Migrations
dotnet ef database update

# تشغيل المشروع
dotnet run
```

✅ **النظام الخلفي سيعمل على:** `https://localhost:5001` (HTTPS) و `http://localhost:5000` (HTTP)

### 4️⃣ إعداد التطبيق المحمول

#### أ. تحديث IP Address:
افتح ملف `SmartFleet.Mobile/smartfleet_app/lib/config/api_config.dart`
```dart
static String _deviceUrl = 'http://YOUR_IP_ADDRESS:5001';
```

#### ب. تشغيل التطبيق:
```bash
# الانتقال لمجلد Flutter
cd SmartFleet.Mobile/smartfleet_app

# تحميل التبعيات
flutter pub get

# تشغيل التطبيق
flutter run
```

### 5️⃣ إعداد النظام المدمج

#### أ. فتح كود Arduino:
افتح ملف `SmartFleet.Arduino/SmartFleetEmbedded/SmartFleetEmbedded.ino`

#### ب. تحديث الإعدادات:
```cpp
const char* SIM_CARD_NUMBER = "YOUR_SIM_NUMBER";
const char* DEVICE_ID = "YOUR_DEVICE_ID";
const char* SERVER_URL = "YOUR_SERVER_URL";
```

#### ج. رفع الكود:
1. اربط Arduino بالكمبيوتر
2. اختر البورت الصحيح
3. اضغط Upload

---

## 🔑 المستخدمين الافتراضيين

يتم إنشاء المستخدمين التاليين تلقائياً:

### 👤 مدير الأسطول:
- **البريد الإلكتروني:** `fleetmanager@smartfleet.com`
- **كلمة المرور:** `FleetManager123!`
- **الدور:** FleetManager

### 👤 السائق:
- **البريد الإلكتروني:** `driver@smartfleet.com`
- **كلمة المرور:** `Driver123!`
- **الدور:** Driver

### 👤 المستخدم العادي:
- **البريد الإلكتروني:** `user@smartfleet.com`
- **كلمة المرور:** `User123!`
- **الدور:** NormalUser

---

## 🐛 حل المشاكل الشائعة

### ❌ مشكلة اتصال قاعدة البيانات:
```bash
# التحقق من اتصال SQL Server
dotnet ef database update --verbose
```

### ❌ مشكلة تبعيات Flutter:
```bash
# تنظيف وإعادة تحميل التبعيات
flutter clean
flutter pub get
```

### ❌ مشكلة JWT Token:
تأكد من:
- صحة `Jwt:Key` في `appsettings.json`
- تطابق الإعدادات في الموبايل والباك إند

### ❌ مشكلة SignalR:
```bash
# تحقق من CORS settings في Program.cs
# تأكد من أن SignalR Hub يعمل على نفس المنفذ
```

---

## 📊 اختبار النظام

### 1️⃣ اختبار النظام الخلفي:
- افتح `https://localhost:5001`
- سجل دخول بأحد المستخدمين
- تحقق من لوحة التحكم

### 2️⃣ اختبار API:
```bash
# اختبار API مع Postman
POST http://localhost:5001/api/authapi/login
{
  "email": "fleetmanager@smartfleet.com",
  "password": "FleetManager123!"
}
```

### 3️⃣ اختبار التطبيق المحمول:
- شغل التطبيق على المحاكي
- سجل دخول بأحد المستخدمين
- تحقق من الإشعارات

### 4️⃣ اختبار Arduino:
- افتح Serial Monitor
- تحقق من إرسال بيانات GPS
- راقب الاستجابة من الخادم

---

## 🔧 الصيانة والتحديث

### 📊 مراقبة الأداء:
- استخدم **SQL Server Profiler**
- راقب استهلاك الذاكرة
- تحقق من أداء API

### 🔄 التحديثات:
```bash
# تحديث قاعدة البيانات
dotnet ef migrations add NewMigration
dotnet ef database update

# تحديث التطبيق المحمول
flutter pub upgrade
```

### 📱 النشر:
```bash
# إنشاء APK للأندرويد
flutter build apk --release

# إنشاء IPA للآيفون
flutter build ios --release
```

---

## 📞 الدعم الفني

### 🆘 في حالة مواجهة مشاكل:
1. تحقق من هذا الدليل أولاً
2. راجع ملف `README.md`
3. ابحث في **GitHub Issues**
4. اتصل بالدعم الفني

### 🔗 روابط مفيدة:
- **ASP.NET Core Docs:** https://docs.microsoft.com/en-us/aspnet/core/
- **Flutter Docs:** https://flutter.dev/docs
- **Arduino Reference:** https://www.arduino.cc/reference/en/

---

## ✅ قائمة التحقق

### قبل التشغيل:
- [ ] تم تثبيت جميع المتطلبات
- [ ] تم إنشاء قاعدة البيانات
- [ ] تم تحديث Connection String
- [ ] تم تحديث IP Address في Flutter
- [ ] تم تحديث إعدادات Arduino

### بعد التشغيل:
- [ ] النظام الخلفي يعمل على localhost:5001
- [ ] يمكن تسجيل الدخول بالمستخدمين الافتراضيين
- [ ] التطبيق المحمول يتصل بالخادم
- [ ] SignalR يعمل للإشعارات
- [ ] Arduino يرسل بيانات GPS

---

<div align="center">
  <h3>🎉 تهانينا! نظام SmartFleet جاهز للاستخدام</h3>
  <p>للدعم: support@smartfleet.com</p>
</div> 