# 🏗️ بنية المشروع - SmartFleet

## 📁 المجلدات الرئيسية

### 🌐 SmartFleet.Web/
**النظام الخلفي (ASP.NET Core 8.0)**
- 📂 `Controllers/` - مراقبات MVC + API Controllers
- 📂 `Models/` - نماذج قاعدة البيانات
- 📂 `Services/` - خدمات منطق العمل
- 📂 `Views/` - صفحات Razor
- 📂 `wwwroot/` - الملفات الثابتة (CSS, JS, Images)
- 📂 `Data/` - DbContext وإعدادات قاعدة البيانات
- 📂 `Hubs/` - SignalR Hubs للإشعارات الفورية
- 📂 `SmartFleet.Tests/` - اختبارات الوحدة

### 📱 SmartFleet.Mobile/
**التطبيق المحمول (Flutter)**
- 📂 `smartfleet_app/` - مشروع Flutter الرئيسي
  - 📂 `lib/screens/` - شاشات التطبيق
  - 📂 `lib/services/` - خدمات API وSignalR
  - 📂 `lib/models/` - نماذج البيانات
  - 📂 `lib/widgets/` - عناصر UI مخصصة
  - 📂 `lib/theme/` - تصميم التطبيق
  - 📂 `lib/config/` - إعدادات التطبيق
  - 📄 `pubspec.yaml` - تبعيات Flutter

### 🔧 SmartFleet.Arduino/
**النظام المدمج (Arduino + SIM808)**
- 📂 `SmartFleetEmbedded/` - مشروع Arduino
  - 📄 `SmartFleetEmbedded.ino` - كود Arduino الرئيسي
  - تتبع GPS وإرسال البيانات عبر GPRS

### 📦 SmartFleet.Shared/
**الكود المشترك**
- نماذج البيانات المشتركة
- DTOs وEnums
- Constants وConfigurations

### 📚 Documentation/
**التوثيق والملفات المساعدة**
- أدلة التشغيل
- مخططات قاعدة البيانات
- تصميم النظام

## 🔄 تدفق البيانات

```
Arduino (GPS) → ASP.NET Core API → SQL Server
                      ↓
            SignalR Hub → Flutter App
```

## 🛠️ التقنيات المستخدمة

| المكون | التقنية |
|--------|----------|
| Backend | ASP.NET Core 8.0 |
| Database | SQL Server |
| Mobile | Flutter 3.0+ |
| IoT | Arduino + SIM808 |
| Real-time | SignalR |
| Authentication | JWT + Cookies |

## 📋 الملفات المهمة

- `README.md` - دليل المشروع الشامل
- `SETUP.md` - دليل الإعداد والتشغيل
- `PROJECT_STRUCTURE.md` - بنية المشروع (هذا الملف)
- `.gitignore` - ملفات مستثناة من Git
- `Final first term.pdf` - تقرير المشروع
- `Smart Fleet.png` - لوجو المشروع

## ⚙️ إعدادات التطوير

### للباك إند:
1. `appsettings.json` - إعدادات الاتصال
2. `Program.cs` - إعدادات التطبيق
3. Migration files - تحديثات قاعدة البيانات

### للموبايل:
1. `api_config.dart` - إعدادات الاتصال بالخادم
2. `app_theme.dart` - تصميم التطبيق
3. `main.dart` - نقطة دخول التطبيق

### للأردوينو:
1. تحديث `SIM_CARD_NUMBER`
2. تحديث `SERVER_URL`
3. تحديث `DEVICE_ID`

## 🚀 التشغيل السريع

```bash
# Backend
cd SmartFleet.Web
dotnet run

# Mobile
cd SmartFleet.Mobile/smartfleet_app
flutter run

# Arduino
# رفع الكود من Arduino IDE
```

هذه البنية المنظمة تسهل التطوير والصيانة وتوفر فصل واضح بين مكونات النظام. 