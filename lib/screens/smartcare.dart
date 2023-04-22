import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcare/common/theme.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';
import 'package:smartcare/models/daily_tips.dart';
import 'package:smartcare/screens/charts.dart';
import 'package:smartcare/services/api.dart';

class SmartCareScreen extends StatefulWidget {
  const SmartCareScreen({super.key});

  @override
  State<SmartCareScreen> createState() => _SmartCareScreenState();
}

class _SmartCareScreenState extends State<SmartCareScreen> {
  final platform =
      const MethodChannel('com.kevinhectorngetich.smartcare/usage_stats');
  late Future<DailyTips> _tip;

  @override
  void initState() {
    super.initState();
    // getWhatsAppUsageStats();
    _tip = DailyTipApi().getDailyTip();
    getUnlockCount().then((value) {
      setState(() {
        _unclockCounter = value;
      });
    });
    getUsageStats().then((value) {
      setState(() {
        _socialMediaUsage = value;
      });
    });
  }

  DailyTipApi api = DailyTipApi();
  DailyTips tips = DailyTips();

  int? _unclockCounter;
  int? _socialMediaUsage;

  Future<int> getUnlockCount() async {
    final unlockCount = await platform.invokeMethod('getUnlockCount');
    return unlockCount;
  }

  Future<int> getUsageStats() async {
    try {
      DateTime now = DateTime.now();
      DateTime start = DateTime(now.year, now.month, now.day);
      DateTime end = DateTime.now();

      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(start, end);

      // print(infoList);
      var totalUsage = 0;
      for (var info in infoList) {
        totalUsage += info.usage.inHours;
      }

      return totalUsage;
    } on AppUsageException {
      // print(exception);
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundPurple,
      body: SafeArea(
        child: SingleChildScrollView(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ChartScreen()));
                              },
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: myContainerLightpurple,
                  ),
                  // TODO: Use shared preference to store daily tip
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FutureBuilder(
                        future: _tip,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Daily tips:',
                                  style: kTimeSavingTipsTextStyle,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '" ' '${snapshot.data!.q}' ' "',
                                  style: ktimeSavingTipsBody,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '~ ' '${snapshot.data!.a}',
                                      style: ktimeSavingTipsBody,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Daily tips:',
                                  style: kTimeSavingTipsTextStyle,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  ' Life is 10% what happens to us and 90% how we react to it. ',
                                  style: ktimeSavingTipsBody,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '~ ' 'KevinHector',
                                      style: ktimeSavingTipsBody,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/home-card.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              _unclockCounter.toString(),
                              style: khomeCardDigit,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              '''Number of times phone was opened''',
                              style: kcardTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/home-card2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              _socialMediaUsage.toString(),
                              style: khomeCardDigit,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              'Number of hours spent on social media',
                              style: kcardTextStyle,
                            ),
                          ],
                        ),
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
  }
}
