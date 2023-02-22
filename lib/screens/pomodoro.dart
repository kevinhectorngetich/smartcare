import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// import 'dart:math';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class DataItem {
//   int x;
//   double y1;
//   double y2;
//   double y3;
//   DataItem(
//       {required this.x, required this.y1, required this.y2, required this.y3});
// }

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

//   // Generate dummy data to feed the chart
//   // ignore: unused_field
//   final List<DataItem> _myData = List.generate(
//       30,
//       (index) => DataItem(
//             x: index,
//             y1: Random().nextInt(20) + Random().nextDouble(),
//             y2: Random().nextInt(20) + Random().nextDouble(),
//             y3: Random().nextInt(20) + Random().nextDouble(),
//           ));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('KindaCode.com'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30),
//         child: BarChart(BarChartData(
//             borderData: FlBorderData(
//                 border: const Border(
//               top: BorderSide.none,
//               right: BorderSide.none,
//               left: BorderSide(width: 1),
//               bottom: BorderSide(width: 1),
//             )),
//             groupsSpace: 10,
//             barGroups: [
//               BarChartGroupData(x: 1, barRods: [
//                 BarChartRodData(
//                     fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//               BarChartGroupData(x: 2, barRods: [
//                 BarChartRodData(
//                     fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//               BarChartGroupData(x: 3, barRods: [
//                 BarChartRodData(
//                     fromY: 0, toY: 15, width: 15, color: Colors.amber),
//               ]),
//               BarChartGroupData(x: 4, barRods: [
//                 BarChartRodData(
//                     fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//               BarChartGroupData(x: 5, barRods: [
//                 BarChartRodData(
//                     fromY: 0, toY: 11, width: 15, color: Colors.amber),
//               ]),
//               BarChartGroupData(x: 6, barRods: [
//                 BarChartRodData(
//                     fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//               BarChartGroupData(x: 7, barRods: [
//                 BarChartRodData(
//                     fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//               BarChartGroupData(x: 8, barRods: [
//                 BarChartRodData(
//                     fromY: 0,
//                     toY: 10,
//                     width: 15,
//                     color: Colors.amber,
//                     backDrawRodData: BackgroundBarChartRodData(
//                         fromY: 0, toY: 24, color: Colors.cyan, show: true)),
//               ]),
//             ])),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:collection/collection.dart';

class PricePoint {
  final double x;
  final double y;

  PricePoint({required this.x, required this.y});
}

List<PricePoint> get pricePoints {
  final Random random = Random();
  final randomNumbers = <double>[];
  for (var i = 0; i <= 11; i++) {
    randomNumbers.add(random.nextDouble());
  }

  return randomNumbers
      .mapIndexed(
          (index, element) => PricePoint(x: index.toDouble(), y: element))
      .toList();
}

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({super.key});

//  const BarChartWidget({Key? key, required this.points}) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  List<PricePoint>? points;

  // _BarChartWidgetState({required this.points});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
          barGroups: _chartGroups(),
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    return points!
        .map((point) => BarChartGroupData(
            x: point.x.toInt(), barRods: [BarChartRodData(toY: point.y)]))
        .toList();
  }

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
            style: const TextStyle(fontFamily: 'Poppins', color: Colors.white),
          );
        },
      );
}
