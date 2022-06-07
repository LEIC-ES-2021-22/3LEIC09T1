import 'dart:async';
import 'package:logger/logger.dart';
import 'package:uni/controller/local_storage/app_database.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uni/model/entities/lecture_notification_preference.dart';

/// Manages the app's Lectures database.
///
/// This database stores information about the user's
/// lecture notification preferences.
/// See the [LectureNotificationPreference]
/// class to see what data is stored in this database.
class AppLectureNotificationPreferencesDatabase extends AppDatabase {
  static final createScript =
      '''CREATE TABLE lectureNotificationPreferences(id INTEGER PRIMARY KEY, isActive BOOLEAN NOT NULL DEFAULT TRUE)''';

  AppLectureNotificationPreferencesDatabase()
      : super(
            'lectureNotificationPreferences.db',
            [
              createScript,
            ],
            version: 1);

  /// Replaces all of the data in this database with [preferences].
  saveNewLectureNotificationPreferences(
      List<LectureNotificationPreference> preferences) async {
    Logger().i('Saving new lecture preferences: ${preferences}');
    await deleteLectureNotificationPreferences();
    await _insertLectureNotificationPreferences(preferences);
  }

  /// Replaces all of the data in this database with preferences
  /// generate from [lectures]
  saveNewPreferencesThroughLectures(List<Lecture> lectures) async {
    final List<LectureNotificationPreference> preferences = [];
    for (Lecture l in lectures) {
      preferences.add(LectureNotificationPreference(l.id, true));
    }
    await this.saveNewLectureNotificationPreferences(preferences);
  }

  Future<void> setNotificationPreference(
      int lectureId, bool activationValue) async {
    final Database db = await this.getDatabase();
    Logger()
        .i('Updating lecture preference: ${lectureId} - ${activationValue}');
    await db.update(
        'lectureNotificationPreferences', {'isActive': activationValue},
        where: 'id = ?', whereArgs: [lectureId]);
  }

  Future<bool> getNotificationPreference(int lectureId) async {
    final Database db = await this.getDatabase();
    var preference = await db.query('lectureNotificationPreferences',
        columns: ['isActive'], where: 'id = ?', whereArgs: [lectureId]);
    return preference[0]['isActive'] == 1 ? true : false;
  }

  /// Returns a list containing all of the lectures stored in this database.
  Future<List<LectureNotificationPreference>> preferences() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    // Query the table for All The Dogs.
    final List<Map<String, dynamic>> maps =
        await db.query('lectureNotificationPreferences');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return LectureNotificationPreference.fromHtml(
          maps[i]['id'], maps[i]['isActive']);
    });
  }

  /// Adds all items from [preferences] to this database.
  ///
  /// If a row with the same data is present, it will be replaced.
  Future<void> _insertLectureNotificationPreferences(
      List<LectureNotificationPreference> preferences) async {
    for (LectureNotificationPreference preference in preferences) {
      await this.insertInDatabase(
        'lectureNotificationPreferences',
        preference.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Deletes all of the data stored in this database.
  Future<void> deleteLectureNotificationPreferences() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    await db.delete('lectureNotificationPreferences');
  }
}
