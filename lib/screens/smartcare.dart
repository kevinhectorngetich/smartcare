import 'package:flutter/material.dart';
import 'package:smartcare/common/theme.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';

class SmartCareScreen extends StatefulWidget {
  const SmartCareScreen({super.key});

  @override
  State<SmartCareScreen> createState() => _SmartCareScreenState();
}

class _SmartCareScreenState extends State<SmartCareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Smart Care',
                    style: kpageTitleStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/hero-image.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                // height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: kTitleStyle,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Transform your screen time habits with Smart Care, the innovative app that monitors usage and reminds you to take breaks.',
                        style: kparagrapghStyle,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: kviewStats(),
                            child: const Text(
                              'view stats',
                              style: kbuttonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.ac_unit)),
    );
  }
}
