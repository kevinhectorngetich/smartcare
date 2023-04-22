import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:smartcare/common/theme.dart';
import 'package:smartcare/screens/home_screen.dart';
import 'package:smartcare/services/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // print('Initializing FlutterBackground...');

  // await FlutterBackground.initialize();
  // await FlutterBackground.enableBackgroundExecution();
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  // await initializeNotifications();
  await AndroidAlarmManager.initialize();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_launcher',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            importance: NotificationImportance.High,
            channelShowBadge: true,
            playSound: true,
            enableVibration: true,
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required

      debug: true);

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
