import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/models/entities/lesson.dart';

import '../constants/input_decorations.dart';
import '../constants/text_style.dart';
import '../services/isar_service.dart';
import '../widgets/button_widget.dart';

class TimeTable extends StatefulWidget {
  // final IsarService service;

  const TimeTable({
    super.key,
  });

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  IsarService service = IsarService();
  final TimeOfDay _timeOfDay = TimeOfDay.now();
  final TimeOfDay _endTimeNow = TimeOfDay.now();
  int? selectedDateIndex;
  String? selectedDayOfWeek;

  final lessonController = TextEditingController();
  // var selectedDayOfWeek = 'Monday';

  void _addLesson(Lesson lesson) {
    setState(() {
      // update the state with the new lesson
      //? Just my callback
    });
  }

  String getDayOfWeekName(int dayOfWeekIndex) {
    switch (dayOfWeekIndex) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        throw Exception('Invalid day of week index');
    }
  }

  @override
  void initState() {
    // Initialize the selectedDateIndex and selectedDayOfWeek variables
    var now = DateTime.now();
    selectedDateIndex = now.weekday - 1;
    selectedDayOfWeek = getDayOfWeekName(now.weekday);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedDayOfWeek == "Saturday" || selectedDayOfWeek == "Sunday") {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
// Function to convert weekday index to name

    double paddingHeight = MediaQuery.of(context).size.height * 0.05;

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
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _daysOftheWeek.length,
                    itemBuilder: (builder, index) {
                      return InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        onTap: () {
                          setState(() {
                            selectedDateIndex = index;
                            selectedDayOfWeek = isarDaysOftheWeek[index];
                            if (selectedDateIndex == 0) {
                              _scrollController.animateTo(
                                _scrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            } else if (selectedDateIndex! >= 5) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
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
                child: FutureBuilder(
                    future: service.getLessons(selectedDayOfWeek!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Lesson> lessons = snapshot.data as List<Lesson>;
                        // sort lessons by start time
                        lessons
                            .sort((a, b) => a.startTime.compareTo(b.startTime));
                        return ListView.builder(
                            //? Counting from lessons
                            itemCount: lessons.length + 1,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index < lessons.length) {
                                Lesson lesson = lessons[index];
                                //? Schedule notifications recieved from DB
                                scheduleNotification(
                                  // DateTime(
                                  //   DateTime.now().year,
                                  //   DateTime.now().month,
                                  //   DateTime.now().day,
                                  //   startTime?.hour ?? _timeOfDay.hour,
                                  //   startTime?.minute ?? _timeOfDay.minute,
                                  // ),
                                  lesson.startTime,
                                  selectedDayOfWeek!,
                                  lesson.title,
                                  //? changed from lessonController to lesson.title
                                  lesson.id,
                                );

                                return Dismissible(
                                  key: Key(lesson.id.toString()),
                                  onDismissed: (direction) async {
                                    await service.deleteLesson(lesson).then(
                                        (_) => ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    myContainerLightpurple,
                                                content: Text(
                                                    '${lesson.title} removed from db'))));
                                    cancelNotification(lesson.id);

                                    setState(() {
                                      //remove it from the fetched list NICE!!
                                      lessons.removeAt(index);
                                    });
                                  },
                                  child: SizedBox(
                                    // height: 150.0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: cardColors[
                                                index % cardColors.length],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0,
                                              left: 20.0,
                                              bottom: 20.0,
                                              right: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                lesson.title,
                                                style: ktimeTableLesson,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 20.0,
                                                        ),
                                                        const Text(
                                                          'Time:',
                                                          style:
                                                              ktimeTimeTableTimeText,
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        //? START ABD END TIME
                                                        Text(
                                                            '''${DateFormat('hh:mm a').format(DateTime.parse(lesson.startTime.toIso8601String()))} - ${DateFormat('hh:mm a').format(DateTime.parse(lesson.endTime.toIso8601String()))}''',
                                                            style:
                                                                ktimeTableLesson),
                                                      ]),
                                                  SizedBox(
                                                    height: 65.0,
                                                    width: 65.0,
                                                    child: Image.asset(
                                                      imagesPath[index %
                                                          imagesPath.length],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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
                                    _showModalBottomSheet(context, _addLesson,
                                        selectedDayOfWeek!);
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
                                      child: Image.asset(
                                          'assets/images/add-button.png'),
                                    ),
                                  ),
                                );
                              }
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
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

  void _showModalBottomSheet(
    BuildContext context,
    Function(Lesson) addLesson,
    String selectedDayOfWeek,
  ) {
    TimeOfDay? startTime;
    TimeOfDay? stopTime;
    final formKey = GlobalKey<FormState>();

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
                        key: formKey,
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
                            //? ADD to isar DB
                            ButtonWidget(
                              text: 'ADD',
                              onClicked: () {
                                if (formKey.currentState!.validate()) {
                                  service.saveCourse(Lesson()
                                    ..title = lessonController.text
                                    ..startTime = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      startTime?.hour ?? _timeOfDay.hour,
                                      startTime?.minute ?? _timeOfDay.minute,
                                    )
                                    ..endTime = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      stopTime?.hour ?? _endTimeNow.hour,
                                      stopTime?.minute ?? _endTimeNow.minute,
                                    )
                                    ..dayOfWeek = selectedDayOfWeek);

                                  // .then((_) => setState(() {
                                  //       // Refresh your ListView.builder here
                                  //       service
                                  //           .getLessons(selectedDayOfWeek);
                                  //     }));
                                  // service.getLessons(selectedDayOfWeek);
                                  //? Using Callback For Now
                                  addLesson(Lesson());

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor:
                                              myContainerLightpurple,
                                          content: Text(
                                              "New course '${lessonController.text}' saved in DB")));
                                  // createDummyNotification();
                                  Navigator.pop(context);
                                }

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
  'Sat',
  'Sun',
];
List<String> isarDaysOftheWeek = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

List<Color> cardColors = [
  const Color(0xff7F86FF),
  const Color(0xffFFB757),
  const Color(0xff6ABAFF),
  const Color(0xffFF4171),
  const Color(0xff49B583),
];
List<String> imagesPath = [
  'assets/images/react.png',
  'assets/images/shelf.png',
  'assets/images/book.png',
];

void scheduleNotification(DateTime startTime, String dayOfWeek,
    String lessonName, int notificationID) async {
  //? Get the day of the week as an integer (Monday = 1, Tuesday = 2, etc.)
  // int dayOfWeekIndex = DateTime.parse("2023-03-15").weekday;
  // int dayOfWeekIndex = DateTime.now().weekday;

  //? Calculate the difference between the input day of the week and the current day of the week
  // int daysToAdd = (dayOfWeekIndex - getDayOfWeekIndex(dayOfWeek) + 7) % 7;

  //? Calculate the date for the next occurrence of the lesson
  // DateTime nextLessonDate = startTime.add(Duration(days: daysToAdd));

  // Create a notification that repeats every week on the same day and time
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationID,
      channelKey: 'basic_channel',
      title: 'Lesson Reminder',
      body: 'Your $lessonName lesson is starting soon!',
      customSound: null,
    ),
    schedule: NotificationCalendar(
      weekday: getDayOfWeekIndex(dayOfWeek),
      hour: startTime.hour,
      minute: startTime.minute,
      second: 0,
      millisecond: 0,
      allowWhileIdle: false,
      repeats: true,
    ),
  );
}

int getDayOfWeekIndex(String dayOfWeek) {
  switch (dayOfWeek) {
    case 'Monday':
      return 1;
    case 'Tuesday':
      return 2;
    case 'Wednesday':
      return 3;
    case 'Thursday':
      return 4;
    case 'Friday':
      return 5;
    case 'Saturday':
      return 6;
    case 'Sunday':
      return 7;
    default:
      throw Exception('Invalid day of week');
  }
}

void cancelAllNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

void cancelNotification(int notificationId) async {
  await AwesomeNotifications().cancel(notificationId);
}

// void createDummyNotification() async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 1,
//       channelKey: 'basic_channel',
//       title: 'Lesson Reminder',
//       body: 'Your lessonName lesson is starting soon!',
//       // icon: 'resource://drawable/ic_launcher',
//       // largeIcon: 'asset://assets/images/solar.png',
//       // Replace with the path to your image file
//     ),
//     // actionButtons: [
//     //   NotificationActionButton(
//     //     key: 'action1',
//     //     label: 'Open App',
//     //     // autoCancel: true,
//     //   ),
//     //   NotificationActionButton(
//     //     key: 'action2',
//     //     label: 'Dismiss',
//     //     // autoCancel: true,
//     //   ),
//     // ],
//   );
// }
