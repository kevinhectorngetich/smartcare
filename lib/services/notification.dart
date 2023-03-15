import 'package:app_usage/app_usage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// TODO: Modify the messages to different activities for different time
// TODO: Show notifications only twice for an app:

// void showNotification(String appLabel) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'usage_notification_channel_id',
//     'Usage Notification Channel',
//     channelDescription: 'Notifications for app usage',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'App Usage Limit Exceeded',
//     'You have used $appLabel for more than 4 hours',
//     platformChannelSpecifics,
//     payload: 'usage_notification',
//   );
// }
void showNotification(String appLabel) async {
  var now = DateTime.now();
  // var formatter = DateFormat('HH:mm:ss');
  // var formattedTime = formatter.format(now);
  var message = '';

  if (now.hour < 12) {
    message =
        'Good morning! Consider finishing your tasks earlier to free up your day!😃.';
  } else if (now.hour < 18) {
    message = 'Good afternoon! Maybe take a walk 🚶‍♂️ or do your hobby';
  } else {
    message = 'Good evening! Take a break and wind up for bed. 🛌🏻';
  }
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: 0,
    channelKey: 'basic_channel',
    title: 'You have used $appLabel for more than 4 hours',
    body: message,
    wakeUpScreen: true,
    displayOnBackground: true,
  ));
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

    return infoList;
  } on AppUsageException catch (exception) {
    print(exception);
    return [];
  }
}
