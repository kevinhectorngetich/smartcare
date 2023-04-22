import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartcare/models/daily_tips.dart';

class DailyTipApi {
  var url = Uri.parse('https://zenquotes.io/api/today/[your_key]');

  Future<DailyTips> getDailyTip() async {
    final response = await http.get(url);

    final parsed = json.decode(response.body)[0];
    return DailyTips.fromJson(parsed);
  }
}
