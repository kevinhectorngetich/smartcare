import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';
import 'package:smartcare/screens/charts.dart';
import 'package:smartcare/screens/pomodoro.dart';
import 'package:smartcare/screens/smartcare.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final screens = [
    const SmartCareScreen(),
    const ChartScreen(),
    const PomodoroScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: mybackgroundPurple,
          labelTextStyle: MaterialStateProperty.all(kparagrapghStyle),
          // indicatorColor: ,
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: mybottomNavigationPurple,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home_rounded),
              icon: Icon(
                Icons.home_rounded,
                color: Colors.white38,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bar_chart_rounded),
              icon: Icon(Icons.bar_chart_rounded, color: Colors.white38),
              label: 'Chart',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.more_time_rounded),
              icon: Icon(Icons.more_time_rounded, color: Colors.white38),
              label: 'Pomodoro',
            ),
          ],
        ),
      ),
    );
  }
}
