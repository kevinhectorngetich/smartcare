import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartcare/models/bar_data.dart';

class BarTitles {
  static SideTitles getBottomTitles() => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          date(double id) => BarData.barData
              .firstWhere((element) => element.id == id.toInt())
              .date;
          return Text(
            '$date',
            style: const TextStyle(color: Colors.white, fontSize: 10.0),
          );
        },
      );
  static SideTitles getSideitles() => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          date(double id) => BarData.barData
              .firstWhere((element) => element.id == id.toInt())
              .id;
          return Text(
            '$date' ' hr(s)',
            style: const TextStyle(color: Colors.white, fontSize: 10.0),
          );
        },
      );
}
