import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class NotificationSoundService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  
  /// تشغيل صوت تنبيه للإشعار الجديد
  static Future<void> playNotificationSound() async {
    try {
      // استخدام صوت النظام الافتراضي للتنبيه
      await SystemSound.play(SystemSoundType.alert);
      
      // يمكن أيضاً استخدام vibration إذا كان الجهاز يدعمه
      await HapticFeedback.heavyImpact();
    } catch (e) {
      print('❌ Error playing notification sound: $e');
    }
  }
  
  /// تشغيل صوت تنبيه مخصص (إذا كان لدينا ملف صوتي)
  static Future<void> playCustomNotificationSound() async {
    try {
      // في حالة وجود ملف صوتي مخصص
      // await _audioPlayer.play(AssetSource('sounds/notification.mp3'));
      
      // للآن نستخدم أصوات النظام
      await playNotificationSound();
    } catch (e) {
      print('❌ Error playing custom notification sound: $e');
    }
  }
  
  /// تشغيل صوت نجاح
  static Future<void> playSuccessSound() async {
    try {
      await SystemSound.play(SystemSoundType.click);
      await HapticFeedback.lightImpact();
    } catch (e) {
      print('❌ Error playing success sound: $e');
    }
  }
  
  /// تشغيل صوت خطأ
  static Future<void> playErrorSound() async {
    try {
      await SystemSound.play(SystemSoundType.alert);
      await HapticFeedback.heavyImpact();
    } catch (e) {
      print('❌ Error playing error sound: $e');
    }
  }
  
  /// إيقاف جميع الأصوات
  static Future<void> stopAllSounds() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('❌ Error stopping sounds: $e');
    }
  }
  
  /// تنظيف الموارد
  static void dispose() {
    _audioPlayer.dispose();
  }
} 