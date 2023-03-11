import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';

import '../constants/input_decorations.dart';
import '../constants/text_style.dart';
import '../widgets/button_widget.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  TimeOfDay _endTimeNow = TimeOfDay.now();
  TimeOfDay? _startTime;
  TimeOfDay? _stopTime;
  final lessonController = TextEditingController();

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
                    itemCount: _classes.length + 1,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < _classes.length) {
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
                                            imagesPath[
                                                index % imagesPath.length],
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
                      } else {
                        return InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          onTap: () {
                            _showModalBottomSheet(context);
                          },
                          child: Container(
                            height: 140.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child:
                                  Image.asset('assets/images/add-button.png'),
                            ),
                          ),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              color: mybackgroundPurple,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 40.0),
                child: Form(
                  // key: ,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: lessonController,
                        autofocus: false,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Second name cannot be empty!");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          lessonController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: tFieldInputDecoration(
                          inputlabeltext: 'Lesson/Title',
                          inputhinttext: 'Mathematics',
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Tap to edit',
                        style: ktapToEditStyle,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(
                        height: 1.0,
                        width: 150.0,
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white30,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          selectStartTime();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Start Time: ',
                                style: kcardTextStyle,
                              ),
                              Text(
                                '${_timeOfDay.hour.toString()}'
                                ':'
                                '${_timeOfDay.minute.toString()}',
                                style: kbottomSheetDigit,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width * 0.77777,
                        child: const Divider(
                          thickness: 0.5,
                          color: Colors.white30,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          selectStopTime();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Stop Time: ',
                                style: kcardTextStyle,
                              ),
                              Text(
                                '${_endTimeNow.hour.toString()}'
                                ':'
                                '${_endTimeNow.minute.toString()}',
                                style: kbottomSheetDigit,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width * 0.77777,
                        child: const Divider(
                          thickness: 0.5,
                          color: Colors.white30,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ButtonWidget(
                        text: 'ADD',
                        onClicked: () {
                          // startTimer();
                          // startisPressed = !startisPressed;
                        },
                        foregroundColor: Colors.white,
                        backgroundColor: mypink,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<void> selectStartTime() async {
    _startTime =
        await showTimePicker(context: context, initialTime: _timeOfDay);
    if (_startTime != null) {
      setState(() {
        _timeOfDay = _startTime!;
      });
    }
  }

  Future<void> selectStopTime() async {
    _stopTime =
        await showTimePicker(context: context, initialTime: _endTimeNow);
    if (_stopTime != null) {
      setState(() {
        _endTimeNow = _stopTime!;
      });
    }
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
