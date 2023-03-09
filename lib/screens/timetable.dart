import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';

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
    int selectedDateIndex = 0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Timetable',
                    style: kpageTitleStyle,
                  ),
                ],
              ),
              SizedBox(
                height: paddingHeight,
              ),
              SizedBox(
                height: 50.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _daysOftheWeek.length,
                    itemBuilder: (builder, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedDateIndex = index;
                          });
                        },
                        child: Container(
                          width: 65,
                          decoration: BoxDecoration(
                              color: index == selectedDateIndex
                                  ? myContainerLightpurple
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Center(
                            child: Text(
                              _daysOftheWeek[index],
                              style: ktimeTableDate,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: paddingHeight,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _classes.length,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        // height: 150.0,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: cardColors[index],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 20.0,
                                  bottom: 20.0,
                                  right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _lessons[index],
                                    style: ktimeTableLesson,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            const Text(
                                              'Time:',
                                              style: ktimeTimeTableTimeText,
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(_time[index],
                                                style: ktimeTableLesson),
                                          ]),
                                      SizedBox(
                                        height: 65.0,
                                        width: 65.0,
                                        child: Image.asset(
                                          imagesPath[index],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<String> _daysOftheWeek = [
  'Mon',
  'Tue',
  'Wed',
  'Thur',
  'Fri',
];

Map<String, String> _classes = {
  'Organization Management': '8.00 AM - 10.00 AM',
  'Project Management': '10.00 AM - 1.00 PM',
};
var _lessons = _classes.keys.toList();
var _time = _classes.values.toList();

List<Color> cardColors = [
  const Color(0xff7F86FF),
  const Color(0xffFFB757),
  const Color(0xffFF5B47),
  const Color(0xffFF4171),
  const Color(0xff49B583),
];
List<String> imagesPath = [
  'assets/images/react.png',
  'assets/images/shelf.png',
  'assets/images/book.png',
];
