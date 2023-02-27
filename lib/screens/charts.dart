import 'dart:typed_data';

import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';
import 'package:smartcare/models/bar_data.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

Map<String, String> appImages = {
  'instagaram': 'assets/images/instagram.png',
  'whatsapp': 'assets/images/whatsapp.png',
  'facebook': 'assets/images/instagram.png',
  'meta': 'assets/images/whatsapp.png',
};

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

  @override
  void initState() {
    super.initState();
    _infos = getUsageStats();
  }

  Future<List<AppUsageInfo>> getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 24));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);
      return infoList;
    } on AppUsageException catch (exception) {
      print(exception);
      return [];
    }
  }

  void getAppIconMethod(String packageName) async {
    Application? app = await DeviceApps.getApp(packageName);
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
                                  // getAppIconMethod();
                                  //TODO: use this icon
                                  // Uint8List? icon = getAppIconMethod(info.packageName);

                                  // final key = appImages.keys.elementAt(index);
                                  // final value =appImages.values.elementAt(index);
                                  // return ListTile(
                                  //   leading: ,
                                  // );
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 30.0,
                                        right: 30.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            // Image.asset(
                                            //   info.,
                                            //   height: 50.0,
                                            //   width: 50.0,
                                            // ),
                                            const SizedBox(
                                              width: 15.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  info.appName,
                                                  style: klistviewTitle,
                                                ),
                                                Text(
                                                  '${info.usage.inHours}'
                                                  ' hrs',
                                                  style: klistviewSubTitle,
                                                ),
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
                                    ),
                                  );
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
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