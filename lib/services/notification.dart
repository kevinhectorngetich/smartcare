import 'package:app_usage/app_usage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void showNotification(String appLabel) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'usage_notification_channel_id',
    'Usage Notification Channel',
    channelDescription: 'Notifications for app usage',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'App Usage Limit Exceeded',
    'You have used $appLabel for more than 4 hours',
    platformChannelSpecifics,
    payload: 'usage_notification',
  );
}

void backgroundTask() async {
  print('Im being executed');
  List<AppUsageInfo> usageStats = await getUsageStats();
  for (var info in usageStats) {
    if (info.usage.inHours >= 4) {
      showNotification(info.appName);
    }
  }
}

Future<List<AppUsageInfo>> getUsageStats() async {
  try {
    DateTime now = DateTime.now();
    DateTime start = DateTime(now.year, now.month, now.day);
    DateTime end = DateTime.now();

    List<AppUsageInfo> infoList = await AppUsage().getAppUsage(start, end);

    // print(infoList);
    var totalUsage = 0;
    for (var info in infoList) {
      totalUsage += info.usage.inHours;
    }
    print(
        'Im in NOTIFICATIONS-----------------------------------------------------');
    print(totalUsage);

    return infoList;
  } on AppUsageException catch (exception) {
    print(exception);
    return [];
  }
}
