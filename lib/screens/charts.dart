import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';
import 'package:smartcare/services/notification.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}
// TODO: Remove the commented code
// TODO: check on the notification icon
// TODO: try to understand if you can add analysis to chart

class _ChartScreenState extends State<ChartScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  SideTitles get _sideTitles => SideTitles(
        showTitles: true,
        interval: 6,
        reservedSize: 32.0,
        getTitlesWidget: (value, meta) => Text(
          value == 0 ? '0' : '${value.toInt()}' ' hr',
          style: const TextStyle(
              fontFamily: 'Poppins', color: Colors.white, fontSize: 10.0),
        ),
      );

  Future<List<AppUsageInfo>>? _infos;
  Future<Map<String, int>?>? weekly;
  Map<String, int>? usageData;

  @override
  void initState() {
    super.initState();
    _infos = getUsageStats();
    backgroundTask();
    // initializeNotifications();
    // weekly = getUsageStatsForWeek();
    // print('for```````MethodChannel');
    // getWhatsAppUsageStats();
    getUsageStatsForWeek().then((data) {
      setState(() {
        usageData = data;
      });
    });

    // printUsageStatsForWeek();
    // getAppUsageStats();
  }

  final platform =
      const MethodChannel('com.kevinhectorngetich.smartcare/usage_stats');

  Future<Map<String, int>?> getUsageStatsForWeek() async {
    final Map<String, dynamic> args = <String, dynamic>{};
    final Map<String, int>? usageStatsMap = await platform
        .invokeMapMethod<String, int>('getUsageStatsForWeek', args);
    return usageStatsMap;
  }

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
                  'The total amount of time spent using the phone',
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
                        ),
                        maxY: 24,
                        groupsSpace: 12,
                        gridData: FlGridData(
                          show: false,
                          checkToShowHorizontalLine: (value) => value % 3 == 0,
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
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
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
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 10.0),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(sideTitles: _sideTitles)),

                        //? trail 3
                        barGroups: usageData?.keys.map((day) {
                          final index = usageData!.keys.toList().indexOf(day);
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: usageData![day]!.toDouble(),
                                color: mybarRodOrange,
                                borderRadius: BorderRadius.circular(20),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  color: Colors.white30,
                                  fromY: 0,
                                  toY: 24,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: paddingHeight,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
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

                                  // FORMATTER FOR RETURN TYPE OF ANDROID
                                  String extractString() {
                                    if (info.appName != 'android') {
                                      return info.appName;
                                    } else {
                                      String input = info.packageName;
                                      int startIndex = input.indexOf('com.') +
                                          4; // Add 4 to skip "com."
                                      // int endIndex =
                                      //     input.indexOf('.', startIndex);
                                      //? For now am using input.length since there
                                      //? is a variations of package name: like:
                                      //? 'com.github.android' and 'com.android.chrome'
                                      //? instead of endIndex
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
