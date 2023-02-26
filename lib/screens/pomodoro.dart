import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:smartcare/common/theme.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';
import 'package:smartcare/widgets/button_widget.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  // Duration duration = Duration();
  Duration maxMinutes = const Duration(minutes: 25);
  Timer? timer;
  double _progressValue = 0.0;

  // @override
  // void initState() {
  //   super.initState();
  //   startTimer();
  // }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      return minusTime();
    });
  }

  void reset() {
    setState(() {
      maxMinutes = const Duration(minutes: 25);
    });
  }

  void minusTime() {
    setState(() {
      final seconds = maxMinutes.inSeconds - 1;
      if (seconds < 0) {
        timer?.cancel();
        reset();
        startisPressed = !startisPressed;
      } else {
        maxMinutes = Duration(seconds: seconds);
        _progressValue += 1 / 1500;
      }
      print('$_progressValue' 'in set state: below is out');

      // print(maxMinutes.inSeconds);
    });
    print(_progressValue);
  }

  // var isRunning = false;
  // var isCompleted = true;

  void cancelTime({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
      // isRunning = false;
    });
  }

  void pauseTime({bool resets = true}) {
    setState(() {
      timer?.cancel();
      // isRunning = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool startisPressed = false;

  @override
  Widget build(BuildContext context) {
    double paddingHeight = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                    'Pomodoro',
                    style: kpageTitleStyle,
                  ),
                ],
              ),
              SizedBox(
                height: paddingHeight,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.32375,
                child: const RiveAnimation.asset(
                  'assets/rive/solar.riv',
                ),
              ),
              SizedBox(
                height: paddingHeight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0, bottom: 8.0, top: 8.0),
                    child: buildTime(),
                  ),
                  // const SizedBox(
                  //   width: 5.0,
                  // ),
                  const Icon(
                    Icons.notifications_active,
                    color: mypink,
                    size: 34,
                  )
                ],
              ),
              LinearProgressIndicator(
                // color: Colors.white30,
                value: _progressValue,
                // valueColor: Color(c),
              ),
              const SizedBox(
                height: 30.0,
              ),
              // TextButton(
              //   style: kstartTimerButton(),
              //   onPressed: () {
              //     setState(() {});
              //   },
              //   child: const Text(
              //     'START',
              //     style: kstartButtonTextStyles,
              //   ),
              // ),
              buildButton(),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildButton() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = maxMinutes.inSeconds == 0;

    return (isRunning || !isCompleted) && startisPressed
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: isRunning ? 'pause' : 'resume',
                  onClicked: () {
                    // print('is it running??????: ' '$isRunning');
                    if (isRunning) {
                      pauseTime();
                    } else {
                      startTimer();
                    }
                  }),
              const SizedBox(
                width: 12.0,
              ),
              ButtonWidget(
                  text: 'cancel',
                  onClicked: () {
                    cancelTime();
                    startisPressed = !startisPressed;
                    _progressValue = 0.0;
                  }),
            ],
          )
        : ButtonWidget(
            text: 'START',
            onClicked: () {
              startTimer();
              startisPressed = !startisPressed;
            },
            foregroundColor: Colors.white,
            backgroundColor: mypink,
          );
  }

  Widget buildTime() {
    //? What it does: 9 --> 09 | 12 --> 12
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(maxMinutes.inMinutes.remainder(60));
    final seconds = twoDigits(maxMinutes.inSeconds.remainder(60));

    return Text(
      '$minutes:$seconds',
      style: ktimerTextStyles,
    );
  }
}
