import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_diabetes/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final NotificationService notificationService;

  FirebaseMessagingService(this.notificationService);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            badge: true, sound: true, alert: true);
    getDeviceFirebaseToken();
    onMessage();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        notificationService.showNotification(CustomNotification(
            id: android.hashCode,
            title: notification.title,
            body: notification.body,
            payload: "payload"));
      }
    });
  }
}
