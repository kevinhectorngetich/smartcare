import 'package:flutter/material.dart';

import '../constants/text_style.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    double paddingHeight = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Pomodoro',
                  style: kpageTitleStyle,
                ),
              ],
            ),
            SizedBox(
              height: paddingHeight,
            ),
          ],
        ),
      ),
    );
  }
}
