class DailyTips {
  String? q;
  String? a;
  String? h;

  DailyTips({this.q, this.a, this.h});

  DailyTips.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    a = json['a'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q'] = q;
    data['a'] = a;
    data['h'] = h;
    return data;
  }
}
