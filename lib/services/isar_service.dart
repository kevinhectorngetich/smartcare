import 'package:isar/isar.dart';

import '../models/entities/lesson.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }
  Future<void> saveCourse(Lesson newLesson) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.lessons.putSync(newLesson));
  }

  Future<List<Lesson>> getLessons(String dayOfWeek) async {
    final isar = await db;
    return await isar.lessons.filter().dayOfWeekEqualTo(dayOfWeek).findAll();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([LessonSchema], inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
}
