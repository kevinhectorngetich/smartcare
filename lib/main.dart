import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:smartcare/common/theme.dart';
import 'package:smartcare/screens/home_screen.dart';
import 'package:smartcare/services/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // print('Initializing FlutterBackground...');

  // await FlutterBackground.initialize();
  // await FlutterBackground.enableBackgroundExecution();
  print('Initializing notifications...');

  await initializeNotifications();
  await AndroidAlarmManager.initialize();
  print('Scheduling periodic alarm with AndroidAlarmManager...');

  runApp(const MyApp());
  await AndroidAlarmManager.periodic(
    const Duration(minutes: 30),
    0, // An ID for the periodic alarm
    backgroundTask,
    // printHello,
    // exact: true,
    // wakeup: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
