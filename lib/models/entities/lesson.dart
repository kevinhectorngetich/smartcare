import 'package:isar/isar.dart';

part 'lesson.g.dart';

@Collection()
class Lesson {
  Id id = Isar.autoIncrement;
  late String title;
  late DateTime startTime;
  late DateTime endTime;
  late String dayOfWeek;
}
