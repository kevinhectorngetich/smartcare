import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcare/common/theme.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';

class SmartCareScreen extends StatefulWidget {
  const SmartCareScreen({super.key});

  @override
  State<SmartCareScreen> createState() => _SmartCareScreenState();
}

class _SmartCareScreenState extends State<SmartCareScreen> {
  final platform =
      const MethodChannel('com.kevinhectorngetich.smartcare/usage_stats');

  @override
  void initState() {
    super.initState();
    // getWhatsAppUsageStats();
  }

  void getWhatsAppUsageStats() async {
    var time1 = await platform.invokeMethod<int>("getWhatsAppUsage");
    var time = Duration(milliseconds: time1 ?? 0);
    print(time);
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: myContainerLightpurple,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Time saving tips:',
                          style: kTimeSavingTipsTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '” Transform your screen time habits with Smart Care, the innovative app that monitors usage and reminds you to take breaks.”',
                          style: ktimeSavingTipsBody,
                        ),
                      ],
                    ),
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
                          children: const [
                            Text(
                              '0',
                              style: khomeCardDigit,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
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
                          children: const [
                            Text(
                              '0',
                              style: khomeCardDigit,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
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
