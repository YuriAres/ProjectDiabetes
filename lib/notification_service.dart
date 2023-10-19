import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class CustomNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationPlugin = FlutterLocalNotificationsPlugin();
  }

  setupNotifications() async {
    await setupTimeZone();
    await initializeNotifications();
  }

  Future<void> setupTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationPlugin.initialize(
        const InitializationSettings(android: android),
        onDidReceiveNotificationResponse: onSelectedNotification);
  }

  onSelectedNotification(NotificationResponse notificationInfo) {
    if (notificationInfo.payload != null &&
        notificationInfo.payload!.isNotEmpty) {}
  }

  showNotification(CustomNotification notification) {
    androidDetails = AndroidNotificationDetails(
        'lembretes_notifications', "Lembretes",
        priority: Priority.max,
        importance: Importance.max,
        enableVibration: true);

    localNotificationPlugin.show(notification.id, notification.title,
        notification.body, NotificationDetails(android: androidDetails),
        payload: notification.payload);
  }

  checkForNotifications() async {
    final details =
        await localNotificationPlugin.getNotificationAppLaunchDetails;
  }
}
