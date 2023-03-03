import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';
import 'package:smartcare/models/bar_data.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:intl/intl.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Sun';
              break;
            case 1:
              text = 'Mon';
              break;
            case 2:
              text = 'Tue';
              break;
            case 3:
              text = 'Wed';
              break;
            case 4:
              text = 'Thur';
              break;
            case 5:
              text = 'Fri';
              break;
            case 6:
              text = 'Sat';
              break;
          }

          return Text(
            text,
            style: const TextStyle(
                fontFamily: 'Poppins', color: Colors.white, fontSize: 10.0),
          );
        },
      );
  SideTitles get _sideTitles => SideTitles(
        showTitles: true,
        interval: 6,
        reservedSize: 32.0,
        getTitlesWidget: (value, meta) => Text(
          value == 0 ? '0' : '${value.toInt()}' ' hrs',
          style: const TextStyle(
              fontFamily: 'Poppins', color: Colors.white, fontSize: 10.0),
        ),
      );
  // AppUsage().getAppUsage(startDate, endDate);
  // Future<List<AppUsageInfo>>? _infos;
  // @override
  // void initState() {
  //   getUsageStats();
  //   super.initState();
  // }

  // void getUsageStats() async {
  //   try {
  //     DateTime endDate = DateTime.now();
  //     DateTime startDate = endDate.subtract(Duration(hours: 1));
  //     List<AppUsageInfo> infoList =
  //         await AppUsage().getAppUsage(startDate, endDate);
  //     // setState(() => _infos = infoList);
  //     print(infoList);
  //     print('above------  above');

  //     for (var info in infoList) {
  //       print(info.toString());
  //       // _infos.add()
  //     }
  //   } on AppUsageException catch (exception) {
  //     print(exception);
  //   }
  // }
  Future<List<AppUsageInfo>>? _infos;
  Future<Map<String, String>?>? weekly;

  @override
  void initState() {
    super.initState();
    // _infos = getUsageStats();
    weekly = getUsageStatsForWeek();
    // print('for```````MethodChannel');
    // getWhatsAppUsageStats();

    print(weekly);
    // printUsageStatsForWeek();
    // getAppUsageStats();
  }

  Future<List<AppUsageInfo>> getUsageStats() async {
    try {
      DateTime now = DateTime.now();
      DateTime start = DateTime(now.year, now.month, now.day - now.weekday);
      DateTime end = DateTime(now.year, now.month, now.day - now.weekday + 7);
      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(start, end);

      // print(infoList);
      var totalUsage = 0;
      for (var info in infoList) {
        totalUsage += info.usage.inHours;
      }
      print('for```````AppUsage');
      print(totalUsage);

      return infoList;
    } on AppUsageException catch (exception) {
      print(exception);
      return [];
    }
  }

  final platform =
      const MethodChannel('com.kevinhectorngetich.smartcare/usage_stats');

  Future<Map<String, String>?> getUsageStatsForWeek() async {
    final Map<String, dynamic> args = <String, dynamic>{};
    final Map<String, String>? usageStatsMap = await platform
        .invokeMapMethod<String, String>('getUsageStatsForWeek', args);
    return usageStatsMap;
  }

  // void getWhatsAppUsageStats() {
  //   platform.invokeMapMethod("getWhatsAppUsage");
  // }

  Future<void> printUsageStatsForWeek() async {
    final usageStatsMap = await getUsageStatsForWeek();
    final formatter = DateFormat('EEEE');
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final day = formatter.format(now.add(Duration(days: i)));
      final usageTime = usageStatsMap![day] ?? 0;
      print('$day: $usageTime hrs used');
    }
  }

  // Map<int, List<UsageInfo>> usageStatsByDay = {};

  // for (int i = 1; i <= 7; i++) {
  //   // loop range to include all days
  //   usageStatsByDay[i] = [];
  // }

  // Future<void> getAppUsageStats() async {
  //   DateTime now = DateTime.now();
  //   DateTime start = DateTime(now.year, now.month, now.day - now.weekday);
  //   DateTime end = DateTime(now.year, now.month, now.day - now.weekday + 7);
  //   // DateTime startOfDay = DateTime(now.year, now.month, now.day);

  //   try {
  //     List<UsageInfo> usageStatsList =
  //         await UsageStats.queryUsageStats(start, end);

  //     for (int i = 1; i <= 7; i++) {
  //       // loop range to include all days
  //       List<UsageInfo> usageStatsListForDay =
  //           usageStatsList.where((usageStats) {
  //         if (usageStats.lastTimeUsed == null ||
  //             usageStats.lastTimeUsed == '0') {
  //           return false;
  //         }
  //         DateTime usageTime = DateTime.fromMillisecondsSinceEpoch(
  //                 int.parse(usageStats.lastTimeUsed!))
  //             .toLocal();
  //         return usageTime.weekday == i;
  //       }).toList();
  //       List<UsageInfo> usageStatsForDay = [];
  //       Duration totalDuration = Duration.zero;

  //       for (UsageInfo usageStats in usageStatsListForDay) {
  //         String dateString = usageStats.lastTimeUsed!;
  //         DateTime usageTime =
  //             DateTime.fromMillisecondsSinceEpoch(int.parse(dateString))
  //                 .toLocal();
  //         usageStatsForDay.add(usageStats);
  //         totalDuration += usageTime.difference(
  //             DateTime(usageTime.year, usageTime.month, usageTime.day));
  //       }

  //       String dayOfWeek = _getDayOfWeek(i);
  //       int minutes =
  //           (totalDuration.inMilliseconds / Duration.millisecondsPerMinute)
  //               .round();
  //       print("$dayOfWeek: $minutes minutes");
  //     }
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }

  // String _getDayOfWeek(int dayOfWeek) {
  //   switch (dayOfWeek) {
  //     case 1:
  //       return 'Sunday';
  //     case 2:
  //       return 'Monday';
  //     case 3:
  //       return 'Tuesday';
  //     case 4:
  //       return 'Wednesday';
  //     case 5:
  //       return 'Thursday';
  //     case 6:
  //       return 'Friday';
  //     case 7:
  //       return 'Saturday';
  //     default:
  //       return '';
  //   }
  // }

  Future<Image> getAppIconMethod(String packageName) async {
    ApplicationWithIcon? app =
        (await DeviceApps.getApp(packageName, true)) as ApplicationWithIcon?;
    return Image.memory(app!.icon);
  }

  @override
  Widget build(BuildContext context) {
    double paddingHeight = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      backgroundColor: mybackgroundPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Charts',
                  style: kpageTitleStyle,
                ),
                SizedBox(
                  height: paddingHeight,
                ),
                const Text(
                  'The total amount of tme spent using the phone',
                  style: kpageBodyStyle,
                ),
                SizedBox(
                  height: paddingHeight,
                ),
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: myContainerLightpurple,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: BarChart(
                      BarChartData(
                          borderData: FlBorderData(
                            show: false,

                            // border: Border.all(
                            //   style: BorderStyle.solid,
                            //   color: Colors.white30,
                            // ),
                          ),
                          maxY: 24,
                          groupsSpace: 12,
                          gridData: FlGridData(
                            show: false,
                            checkToShowHorizontalLine: (value) =>
                                value % 3 == 0,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white,
                                strokeWidth: 2.8,
                              );
                            },
                          ),
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              // bottomTitles:
                              bottomTitles:
                                  AxisTitles(sideTitles: _bottomTitles),
                              leftTitles: AxisTitles(sideTitles: _sideTitles)),

                          // backgroundColor:
                          barGroups: BarData.barData
                              .map(
                                (data) =>
                                    BarChartGroupData(x: data.id, barRods: [
                                  BarChartRodData(
                                    toY: data.hoursUsed,
                                    color: mybarRodOrange,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    backDrawRodData: BackgroundBarChartRodData(
                                        fromY: 0,
                                        toY: 24,
                                        color: Colors.white30,
                                        show: true),
                                  ),
                                ]),
                              )
                              .toList()),
                    ),
                  ),
                ),
                SizedBox(
                  height: paddingHeight,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: myContainerLightpurple,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FutureBuilder(
                        future: _infos,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // AppUsageInfo appUsageInfo = AppUsageInfo();
                            List<AppUsageInfo> infoList = snapshot.data!;
                            return ListView.builder(

                                // itemCount: appImages.length,
                                itemCount: infoList.length,
                                itemBuilder: (context, index) {
                                  AppUsageInfo info = infoList[index];

                                  // FORMATTER FO RETURN TYPE OF ANDROID
                                  String extractString() {
                                    if (info.appName != 'android') {
                                      return info.appName;
                                    } else {
                                      String input = info.packageName;
                                      int startIndex = input.indexOf('com.') +
                                          4; // Add 4 to skip "com."
                                      int endIndex =
                                          input.indexOf('.', startIndex);
                                      //? For now am using input.length since there
                                      //? is a variations of package name: like:
                                      //? 'com.github.android' and 'com.android.chrome'
                                      return input.substring(
                                          startIndex, input.length);
                                    }
                                  }

                                  var appName = extractString();
                                  // UI FOR TIME USAGE IN LISTVIEW
                                  Widget buildTime() {
                                    //? What it does: 9 --> 09 | 12 --> 12
                                    String twoDigits(int n) =>
                                        n.toString().padLeft(1, '0');
                                    final hours = twoDigits(
                                        info.usage.inHours.remainder(60));
                                    final minutes = twoDigits(
                                        info.usage.inMinutes.remainder(60));
                                    var check1hr = hours == '1' ? 'hr' : 'hrs';
                                    var check1min =
                                        minutes == '1' ? 'min' : 'mins';

                                    return Text(
                                      '$hours $check1hr $minutes $check1min',
                                      style: klistviewSubTitle,
                                    );
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 30.0,
                                        right: 30.0),
                                    child: FutureBuilder<Image>(
                                        future:
                                            getAppIconMethod(info.packageName),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 50.0,
                                                      width: 50.0,
                                                      child: snapshot.data!,
                                                    ),
                                                    const SizedBox(
                                                      width: 15.0,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 150.0,
                                                          child: Text(
                                                            appName,
                                                            style:
                                                                klistviewTitle,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   '${info.usage.inHours}'
                                                        //   ' hrs',
                                                        //   style:
                                                        //       klistviewSubTitle,
                                                        // ),
                                                        buildTime(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                const Divider(
                                                  color: Colors.white24,
                                                ),
                                              ],
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Text(
                                                'Error loading icon');
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        }),
                                  );
                                });
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// TODO: Use icons 7.40 - 8.40 AM
// TODO: Add all the time_usage and use it in chart 9-10.00 AM
// TODO: Figure out how to notify user if 4hrs is passed 2.00-5.00 PM
// IF COMPLETED TAKE A PROUD HAPPY BREAK AND FOCUS ON STUDYING



      // usageStatsList.forEach((UsageInfo usageStats) {
      //   // DateTime usageTime = DateTime.parse(usageStats.lastTimeUsed!).toLocal();
      //   String dateString = usageStats.lastTimeUsed!;
      //   print('```````````AWOOOOOO```````````');
      //   print(dateString);
      //   DateTime usageTime =
      //       DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString).toLocal();

      //   // DateTime usageTime = DateTime.fromMillisecondsSinceEpoch(
      //   //     usageStats.lastTimeUsed!.inMillisecondsSinceEpoch);

      //   if (usageTime.weekday >= 1 && usageTime.weekday <= 7) {
      //     usageStatsByDay[usageTime.weekday - 1]!.add(usageStats);
      //   }

      //? For Loop for days
      
      // for (int i = 1; i <= 7; i++) {
      //   // change loop range to include all days
      //   List<UsageInfo> usageStatsForDay = usageStatsByDay[i]!;
      //   Duration totalDuration = Duration.zero;

      //   for (UsageInfo usageStats in usageStatsList) {
      //     // print(usageStats.lastTimeStamp);
      //     if (usageStats.lastTimeUsed! != '0') {
      //       String dateString = usageStats.lastTimeUsed!;
      //       if (dateString != null) {
      //         DateTime usageTime =
      //             DateTime.fromMillisecondsSinceEpoch(int.parse(dateString))
      //                 .toLocal();

      //         if (usageTime.weekday == i) {
      //           // change day comparison to match loop range
      //           usageStatsForDay.add(usageStats);
      //           // totalDuration += usageTime.difference(startOfDay);
      //           totalDuration += usageTime.difference(
      //               DateTime(usageTime.year, usageTime.month, usageTime.day));
      //         }
      //       }
      //     }
      //   }

      //   String dayOfWeek = _getDayOfWeek(i);
      //   print("$dayOfWeek: ${totalDuration.inMinutes} minutes");
      // }
      // for (int i = 1; i <= 7; i++) {
      //   // change loop range to include all days
      //   List<UsageInfo> usageStatsListForDay =
      //       usageStatsList.where((usageStats) {
      //     if (usageStats.lastTimeUsed == null ||
      //         usageStats.lastTimeUsed == '0') {
      //       return false;
      //     }
      //     DateTime usageTime = DateTime.fromMillisecondsSinceEpoch(
      //             int.parse(usageStats.lastTimeUsed!))
      //         .toLocal();
      //     return usageTime.weekday == i;
      //   }).toList();
      //   List<UsageInfo> usageStatsForDay = [];
      //   Duration totalDuration = Duration.zero;

      //   for (UsageInfo usageStats in usageStatsListForDay) {
      //     String dateString = usageStats.lastTimeUsed!;
      //     DateTime usageTime =
      //         DateTime.fromMillisecondsSinceEpoch(int.parse(dateString))
      //             .toLocal();
      //     usageStatsForDay.add(usageStats);
      //     totalDuration += usageTime.difference(
      //         DateTime(usageTime.year, usageTime.month, usageTime.day));
      //   }

      //   String dayOfWeek = _getDayOfWeek(i);
      //   print("$dayOfWeek: ${totalDuration.inMinutes} minutes");
      // }