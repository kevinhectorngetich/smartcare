import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:smartcare/common/theme.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
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
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
                    child: Text(
                      '24.59',
                      style: ktimerTextStyles,
                    ),
                  ),
                  Icon(
                    Icons.notifications_active,
                    color: mypink,
                  )
                ],
              ),
              const LinearProgressIndicator(
                  // color: Colors.white30,
                  // value: 30.0,
                  // valueColor: Color(c),
                  ),
              const SizedBox(
                height: 30.0,
              ),
              TextButton(
                style: kstartTimerButton(),
                onPressed: () {
                  setState(() {});
                },
                child: const Text(
                  'START',
                  style: kstartButtonTextStyles,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
