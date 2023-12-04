import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/firebase_messaging.dart';
import 'package:flutter_diabetes/login.dart';
import 'package:flutter_diabetes/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initializeNotifications();
  tz.initializeTimeZones();

  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        Provider<NotificationService>(
            create: (context) => NotificationService()),
        Provider<FirebaseMessagingService>(
            create: (context) =>
                FirebaseMessagingService(context.read<NotificationService>()))
      ],
      child: const MaterialApp(
        home: LoginPage(),
      )));
}
