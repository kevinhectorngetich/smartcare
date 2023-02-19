import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';
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
        data: const NavigationBarThemeData(
          indicatorColor: mybackgroundPurple,
          // indicatorColor: ,
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: Colors.black,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_library_rounded, color: Colors.white),
              label: 'Chart',
            ),
            NavigationDestination(
              icon: Icon(Icons.person, color: Colors.white),
              label: 'Pomodoro',
            ),
          ],
        ),
      ),
    );
  }
}
