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
                            show: true,

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
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: myContainerLightpurple,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text('$index'),
                          );
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
