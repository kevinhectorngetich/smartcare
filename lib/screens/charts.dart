import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
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
                  child: BarChart(
                    BarChartData(),
                  ),
                ),
                SizedBox(
                  height: paddingHeight,
                ),
                Container(
                  height: 200,
                  color: myContainerLightpurple,
                  child: BarChart(
                    BarChartData(),
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
