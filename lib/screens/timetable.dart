import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    TimeOfDay? startTime;
    TimeOfDay? stopTime;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate,
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
                                  return ("Title cannot be empty!");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                lessonController.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              style: kparagrapghStyle,
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
                              onTap: () async {
                                startTime =
                                    await selectStartTime(context, startTime);
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Start Time: ',
                                      style: kcardTextStyle,
                                    ),
                                    Text(
                                      // '${startTime?.hour.toString() ?? _timeOfDay.hour.toString()}'
                                      // ':'
                                      // '${startTime?.minute.toString() ?? _timeOfDay.minute.toString()}',
                                      DateFormat('hh:mm a').format(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        startTime?.hour ?? _timeOfDay.hour,
                                        startTime?.minute ?? _timeOfDay.minute,
                                      )),
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
                              width:
                                  MediaQuery.of(context).size.width * 0.77777,
                              child: const Divider(
                                thickness: 0.5,
                                color: Colors.white30,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            InkWell(
                              onTap: () async {
                                stopTime =
                                    await selectStopTime(context, stopTime);
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Stop Time: ',
                                      style: kcardTextStyle,
                                    ),
                                    Text(
                                      DateFormat('hh:mm a').format(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        stopTime?.hour ?? _endTimeNow.hour,
                                        stopTime?.minute ?? _endTimeNow.minute,
                                      )),
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
                              width:
                                  MediaQuery.of(context).size.width * 0.77777,
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
                ),
              ),
            ),
          );
        });
  }

  Future<TimeOfDay?> selectStartTime(
      BuildContext context, TimeOfDay? initialTime) async {
    return showTimePicker(
        context: context, initialTime: initialTime ?? _timeOfDay);
  }

  Future<TimeOfDay?> selectStopTime(
      BuildContext context, TimeOfDay? initialTime) async {
    return showTimePicker(
        context: context, initialTime: initialTime ?? _endTimeNow);
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
