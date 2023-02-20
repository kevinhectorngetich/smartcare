// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUsage {
  final String appname;
  final double hoursUsed;
  final String date;
  final int id;
  AppUsage({
    required this.appname,
    required this.hoursUsed,
    required this.date,
    required this.id,
  });

  AppUsage copyWith({
    String? appname,
    double? hoursUsed,
    String? date,
    int? id,
  }) {
    return AppUsage(
      appname: appname ?? this.appname,
      hoursUsed: hoursUsed ?? this.hoursUsed,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appname': appname,
      'hoursUsed': hoursUsed,
      'date': date,
      'id': id,
    };
  }

  factory AppUsage.fromMap(Map<String, dynamic> map) {
    return AppUsage(
      appname: map['appname'] as String,
      hoursUsed: map['hoursUsed'] as double,
      date: map['date'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUsage.fromJson(String source) =>
      AppUsage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUsage(appname: $appname, hoursUsed: $hoursUsed, date: $date, id: $id)';
  }

  @override
  bool operator ==(covariant AppUsage other) {
    if (identical(this, other)) return true;

    return other.appname == appname &&
        other.hoursUsed == hoursUsed &&
        other.date == date &&
        other.id == id;
  }

  @override
  int get hashCode {
    return appname.hashCode ^ hoursUsed.hashCode ^ date.hashCode ^ id.hashCode;
  }
}
