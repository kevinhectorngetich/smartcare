import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';

class SmartCareScreen extends StatefulWidget {
  const SmartCareScreen({super.key});

  @override
  State<SmartCareScreen> createState() => _SmartCareScreenState();
}

class _SmartCareScreenState extends State<SmartCareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPurple,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: const [
                Text('Smart Care'),
              ],
            ),
            Container(
              height: 30,
              color: primaryColorLightpurple,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.ac_unit)),
    );
  }
}
