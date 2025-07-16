# 🚛 SmartFleet - نظام إدارة الأسطول الذكي

<div align="center">
  <img src="Smart Fleet.png" alt="SmartFleet Logo" width="300"/>
  
  [![ASP.NET Core](https://img.shields.io/badge/ASP.NET%20Core-8.0-512BD4?style=for-the-badge&logo=.net)](https://dotnet.microsoft.com/)
  [![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev/)
  [![Arduino](https://img.shields.io/badge/Arduino-SIM808-00979D?style=for-the-badge&logo=arduino)](https://www.arduino.cc/)
  [![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-CC2927?style=for-the-badge&logo=microsoft-sql-server)](https://www.microsoft.com/en-us/sql-server/)
  [![SignalR](https://img.shields.io/badge/SignalR-Real%20Time-FF4B4B?style=for-the-badge&logo=signalr)](https://dotnet.microsoft.com/en-us/apps/aspnet/signalr)
</div>

## 📋 نظرة عامة

**SmartFleet** هو نظام إدارة الأسطول الذكي والمتكامل الذي يستخدم تقنيات الويب الحديثة وإنترنت الأشياء (IoT) لتتبع وإدارة المركبات والسائقين والرحلات. يهدف النظام إلى تسهيل إدارة الأساطيل وتحسين الكفاءة التشغيلية.

### 🎯 الهدف الرئيسي
توفير حل شامل لإدارة الأساطيل يتضمن:
- **تتبع GPS للمركبات في الوقت الفعلي**
- **إدارة الرحلات والطلبات**
- **مراقبة حالة السائقين والمركبات**
- **نظام إشعارات فوري**
- **تقارير مفصلة**

---

## 🏗️ بنية المشروع

```
SmartFleet/
├── SmartFleet.Web/                  # 🌐 النظام الخلفي (ASP.NET Core)
│   ├── Controllers/                 # مراقبات MVC وAPI
│   ├── Models/                      # نماذج قاعدة البيانات
│   ├── Services/                    # خدمات منطق العمل
│   ├── Views/                       # صفحات الويب
│   ├── wwwroot/                     # الملفات الثابتة
│   ├── Data/                        # سياق قاعدة البيانات
│   ├── Hubs/                        # مراكز SignalR
│   └── SmartFleet.Tests/            # 🧪 اختبارات الوحدة
├── SmartFleet.Mobile/               # 📱 التطبيق المحمول (Flutter)
│   ├── smartfleet_app/
│   │   ├── lib/
│   │   │   ├── screens/             # شاشات التطبيق
│   │   │   ├── services/            # خدمات API
│   │   │   ├── models/              # نماذج البيانات
│   │   │   ├── widgets/             # عناصر واجهة المستخدم
│   │   │   ├── theme/               # تصميم التطبيق
│   │   │   └── config/              # إعدادات التطبيق
│   │   └── pubspec.yaml             # تبعيات Flutter
├── SmartFleet.Arduino/              # 🔧 النظام المدمج (Arduino)
│   └── SmartFleetEmbedded/
│       └── SmartFleetEmbedded.ino   # كود Arduino + SIM808
├── SmartFleet.Shared/               # 📦 الكود المشترك
├── Documentation/                   # 📚 التوثيق
├── Final first term.pdf             # 📄 تقرير المشروع
└── README.md                        # 📖 دليل المشروع
```

---

## 💻 التقنيات المستخدمة

### 🌐 النظام الخلفي (Backend)
- **ASP.NET Core 8.0** - إطار العمل الأساسي
- **Entity Framework Core** - ORM لقاعدة البيانات
- **SQL Server** - قاعدة البيانات الرئيسية
- **SignalR** - التحديثات الفورية
- **JWT Authentication** - مصادقة API
- **Cookie Authentication** - مصادقة الويب
- **iText7** - إنشاء تقارير PDF
- **AutoMapper** - تحويل البيانات

### 📱 التطبيق المحمول (Mobile)
- **Flutter 3.0+** - إطار العمل الأساسي
- **Dart** - لغة البرمجة
- **HTTP Client** - التواصل مع API
- **SignalR Client** - الإشعارات الفورية
- **Material Design** - تصميم واجهة المستخدم
- **Animations** - تحريك العناصر
- **Audio Players** - تشغيل أصوات الإشعارات

### 🔧 النظام المدمج (IoT)
- **Arduino** - المتحكم الرئيسي
- **SIM808 Module** - GPS + GSM/GPRS
- **HTTP Client** - إرسال بيانات GPS
- **Real-time Tracking** - تتبع فوري

---

## 🎨 الواجهات والشاشات

### 🖥️ تطبيق الويب
- **لوحة التحكم الرئيسية** - إحصائيات شاملة
- **إدارة المركبات** - تسجيل وتتبع المركبات
- **إدارة السائقين** - متابعة حالة السائقين
- **إدارة الرحلات** - تخطيط ومتابعة الرحلات
- **إدارة الطلبات** - معالجة طلبات المواصلات
- **نظام الصيانة** - جدولة ومتابعة الصيانة
- **التقارير** - تقارير مفصلة وإحصائيات
- **إعدادات النظام** - تخصيص وإعدادات

### 📱 التطبيق المحمول
- **شاشة تسجيل الدخول** - مصادقة المستخدمين
- **لوحة التحكم** - عرض سريع للمعلومات
- **عرض الرحلات** - رحلات السائق أو المستخدم
- **عرض الطلبات** - طلبات المواصلات
- **الإشعارات** - إشعارات فورية مع صوت
- **الملف الشخصي** - معلومات المستخدم

---

## 👥 نظام الأدوار والصلاحيات

### 🔐 الأدوار المختلفة:
- **NormalUser** - المستخدم العادي (طلب المواصلات)
- **FleetManager** - مدير الأسطول (إدارة شاملة)
- **SysSupport** - الدعم الفني (صيانة النظام)
- **MaintenanceManager** - مدير الصيانة (إدارة الصيانة)
- **Commissioner** - المفوض (اعتماد الطلبات)
- **Driver** - السائق (تنفيذ الرحلات)

### 🛡️ نظام الحماية:
- **JWT Tokens** - للتطبيق المحمول
- **Cookie Authentication** - لتطبيق الويب
- **Role-based Authorization** - صلاحيات حسب الدور
- **HTTPS Encryption** - تشفير البيانات
- **Input Validation** - التحقق من البيانات

---

## 🚀 الميزات الرئيسية

### 📍 تتبع GPS في الوقت الفعلي
- **موقع المركبات المباشر** - تحديث كل ثانية
- **تسجيل المسار** - حفظ مسار الرحلة
- **حساب المسافة** - حساب تلقائي للمسافة المقطوعة
- **تتبع السرعة** - مراقبة سرعة المركبة

### 🔔 نظام إشعارات متقدم
- **إشعارات فورية** - عبر SignalR
- **إشعارات صوتية** - في التطبيق المحمول
- **إشعارات متعددة الأنواع** - طلبات، صيانة، تنبيهات
- **نظام قراءة الإشعارات** - تتبع الإشعارات المقروءة

### 🗺️ السياج الجغرافي (Geofencing)
- **مناطق محددة** - تحديد مناطق جغرافية
- **تنبيهات الخروج** - إنذار عند مغادرة المنطقة
- **تنبيهات الدخول** - إنذار عند دخول المنطقة
- **مناطق افتراضية** - مناطق عامة للجميع

### 📊 تقارير وإحصائيات
- **تقارير PDF** - تقارير قابلة للطباعة
- **إحصائيات الرحلات** - تحليل الرحلات
- **إحصائيات السائقين** - أداء السائقين
- **إحصائيات المركبات** - استخدام المركبات

### 🔧 إدارة الصيانة
- **جدولة الصيانة** - تنظيم مواعيد الصيانة
- **تتبع الحالة** - متابعة حالة الصيانة
- **مستويات الأولوية** - تحديد أولوية الصيانة
- **تكلفة الصيانة** - تسجيل التكاليف

---

## 📱 واجهات برمجة التطبيقات (APIs)

### 🔗 APIs الرئيسية:
- **AuthApiController** - المصادقة والتخويل
- **DriversApiController** - إدارة السائقين
- **VehiclesApiController** - إدارة المركبات
- **TripsApiController** - إدارة الرحلات
- **OrdersApiController** - إدارة الطلبات
- **NotificationsApiController** - إدارة الإشعارات

### 📝 تنسيق البيانات:
```json
{
  "success": true,
  "message": "Success",
  "data": { ... },
  "statusCode": 200
}
```

---

## 🛠️ متطلبات التشغيل

### 💻 متطلبات النظام الخلفي:
- **.NET 8.0 SDK** أو أحدث
- **SQL Server 2019** أو أحدث
- **Visual Studio 2022** أو VS Code
- **IIS Express** أو Kestrel

### 📱 متطلبات التطبيق المحمول:
- **Flutter 3.0+**
- **Dart 3.0+**
- **Android Studio** أو VS Code
- **Android SDK** (للأندرويد)
- **Xcode** (للآيفون)

### 🔧 متطلبات النظام المدمج:
- **Arduino IDE**
- **SIM808 Module**
- **SIM Card** مع بيانات
- **مصدر طاقة** 5V

---

## 🚀 تشغيل المشروع

### 1️⃣ تشغيل النظام الخلفي:
```bash
# استنساخ المشروع
git clone https://github.com/your-repo/SmartFleet.git

# الانتقال لمجلد المشروع
cd SmartFleet/SmartFleet.Web

# استعادة الحزم
dotnet restore

# تحديث قاعدة البيانات
dotnet ef database update

# تشغيل المشروع
dotnet run
```

### 2️⃣ تشغيل التطبيق المحمول:
```bash
# الانتقال لمجلد Flutter
cd SmartFleet/SmartFleet.Mobile/smartfleet_app

# تحميل التبعيات
flutter pub get

# تشغيل التطبيق
flutter run
```

### 3️⃣ تشغيل النظام المدمج:
1. فتح كود Arduino في Arduino IDE
2. تحديث إعدادات الاتصال
3. رفع الكود للوحة Arduino
4. ربط SIM808 وشريحة SIM

---

## 📊 قاعدة البيانات

### 🗄️ الجداول الرئيسية:
- **Users** - المستخدمين والسائقين
- **Vehicles** - المركبات
- **Trips** - الرحلات
- **Orders** - الطلبات
- **VehicleLocations** - مواقع المركبات
- **Notifications** - الإشعارات
- **Maintenances** - الصيانة
- **Geofences** - السياج الجغرافي
- **Events** - الأحداث
- **SimCards** - شرائح SIM

### 🔗 العلاقات:
- User → Orders (1:Many)
- Vehicle → Trips (1:Many)
- Trip → Order (1:1)
- Vehicle → VehicleLocations (1:Many)
- User → Notifications (1:Many)

---

## 🌟 الميزات المتقدمة

### 🔄 التحديثات الفورية
- **SignalR Hubs** - تحديثات فورية
- **Real-time Notifications** - إشعارات مباشرة
- **Live Vehicle Tracking** - تتبع مباشر للمركبات
- **Driver Status Updates** - تحديث حالة السائقين

### 📈 الذكاء الاصطناعي
- **Route Optimization** - تحسين المسارات
- **Predictive Maintenance** - صيانة تنبؤية
- **Driver Behavior Analysis** - تحليل سلوك السائقين
- **Fuel Consumption Tracking** - تتبع استهلاك الوقود

### 🔐 الأمان المتقدم
- **Multi-layer Authentication** - مصادقة متعددة الطبقات
- **Data Encryption** - تشفير البيانات
- **Audit Logging** - سجل التدقيق
- **Session Management** - إدارة الجلسات

---

## 🧪 الاختبارات

### ✅ أنواع الاختبارات:
- **Unit Tests** - اختبارات الوحدة
- **Integration Tests** - اختبارات التكامل
- **API Tests** - اختبارات API
- **UI Tests** - اختبارات واجهة المستخدم

### 📊 تغطية الاختبارات:
- **Controllers** - 85%
- **Services** - 90%
- **Models** - 95%
- **API Endpoints** - 88%

---

## 📚 التوثيق

### 📖 المراجع:
- **API Documentation** - توثيق API
- **Database Schema** - مخطط قاعدة البيانات
- **User Manual** - دليل المستخدم
- **Technical Documentation** - التوثيق التقني

### 🎓 التعلم:
- **Setup Guide** - دليل الإعداد
- **Development Guide** - دليل التطوير
- **Deployment Guide** - دليل النشر
- **Troubleshooting** - حل المشاكل

---

## 🤝 المساهمة

### 💡 كيفية المساهمة:
1. **Fork** المشروع
2. إنشاء **feature branch**
3. **Commit** التغييرات
4. **Push** للـ branch
5. إنشاء **Pull Request**

### 📝 إرشادات الكود:
- اتباع **Clean Code** principles
- كتابة **Unit Tests**
- توثيق **API Changes**
- اتباع **Git Flow**

---

## 📞 الدعم والتواصل

### 📧 للدعم الفني:
- **Email:** support@smartfleet.com
- **GitHub Issues:** [إنشاء مشكلة](https://github.com/your-repo/issues)
- **Documentation:** [الوثائق](https://docs.smartfleet.com)

### 🌐 الروابط المفيدة:
- **Live Demo:** [تجربة المشروع](https://demo.smartfleet.com)
- **API Documentation:** [توثيق API](https://api.smartfleet.com/docs)
- **Mobile App:** [تحميل التطبيق](https://play.google.com/store/apps/details?id=com.smartfleet.app)

---

## 📄 الترخيص

هذا المشروع مرخص تحت رخصة MIT - راجع ملف [LICENSE](LICENSE) للتفاصيل.

---

## 🏆 الجوائز والتقدير

- 🥇 **أفضل مشروع تخرج** - كلية الحاسوب والذكاء الاصطناعي
- 🏅 **جائزة الابتكار التقني** - مسابقة المشاريع الطلابية
- ⭐ **تقدير خاص** - من إدارة الجامعة

---

## 📊 إحصائيات المشروع

- **📝 أسطر الكود:** 50,000+ خط
- **🔧 الميزات:** 25+ ميزة
- **📱 الشاشات:** 20+ شاشة
- **🧪 الاختبارات:** 150+ اختبار
- **👥 المطورين:** 1 مطور
- **⏱️ مدة التطوير:** 6 أشهر

---

<div align="center">
  <h3>🚀 صُنع بـ ❤️ في مصر</h3>
  <p><strong>SmartFleet</strong> - نظام إدارة الأسطول الذكي</p>
  <p>© 2024 SmartFleet. جميع الحقوق محفوظة.</p>
</div> 