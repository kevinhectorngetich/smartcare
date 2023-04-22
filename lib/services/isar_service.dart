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

  Future<void> deleteLesson(Lesson newLesson) async {
    final isar = await db;

    await isar.writeTxn<bool>(() => isar.lessons.delete(newLesson.id));
  }
  // Future<void> deleteLesson(Lesson newLesson) async {
  //   final isar = await db;

  //   await isar.writeTxn((isar) async {
  //     final success = await isar.lessons.delete(newLesson.id);
  //     print('Recipe deleted: $success');
  //     return null; // add a return statement to fix the error
  //   });
  // }

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
