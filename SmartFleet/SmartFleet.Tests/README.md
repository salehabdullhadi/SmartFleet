# SmartFleet.Tests

## نظام اختبارات مشروع SmartFleet

### 🧪 **أدوات الاختبار:**
- **xUnit** - إطار عمل الاختبار الرئيسي
- **Moq** - مكتبة Mock للكائنات
- **FluentAssertions** - لكتابة assertions واضحة

### 🔧 **تشغيل الاختبارات:**

```bash
# من مجلد SmartFleet.Tests
dotnet test

# تشغيل مع تقرير مفصل
dotnet test --logger "console;verbosity=detailed"

# تشغيل مع تقرير التغطية
dotnet test --collect:"XPlat Code Coverage"
```

### 📁 **هيكل الاختبارات:**

```
SmartFleet.Tests/
├── Controllers/          # اختبارات المتحكمات
├── Services/            # اختبارات الخدمات
├── Models/              # اختبارات النماذج
└── Integration/         # اختبارات التكامل
```

### ✅ **اختبارات موجودة:**
- **HomeControllerTests.cs** - اختبارات أساسية

### 📝 **ملاحظات:**
- يتم تطوير الاختبارات تدريجياً حسب الحاجة
- جميع الاختبارات تستخدم أفضل الممارسات في .NET 8
- التركيز على **Unit Tests** و **Integration Tests**

---

*تم إنشاؤه في: 19 يوليو 2025* 