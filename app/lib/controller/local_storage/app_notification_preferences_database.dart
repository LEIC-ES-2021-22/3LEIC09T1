import 'dart:async';
import 'package:logger/logger.dart';
import 'package:uni/controller/local_storage/app_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/utils/constants.dart';

/// Manages the app's Notification Preferences database.
///
/// This database stores information about the user's notification preferences.
/// See the [NotificationPreference] class to see what is stored.
class AppNotificationPreferencesDatabase extends AppDatabase {
  static final createScript =
      '''CREATE TABLE notification_preferences(isActive BOOLEAN NOT NULL, antecedence INTEGER NOT NULL, notificationType TEXT NOT NULL UNIQUE)''';

  AppNotificationPreferencesDatabase()
      : super(
            'notification_preferences.db',
            [
              createScript,
            ],
            version: 1);

  /// Replaces all of the data in this database with [preferences].
  saveNewPreferences(List<NotificationPreference> preferences) async {
    await deletePreferences();
    await _insertPreferences(preferences);
  }

  /// Returns a list containing all of the preferences stored in this database.
  Future<List<NotificationPreference>> preferences() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    // Query the table for All The Preferences.
    final List<Map<String, dynamic>> maps =
        await db.query('notification_preferences');

    // Convert the List<Map<String, dynamic>
    // into a List<NotificationPreference>.
    return List.generate(maps.length, (i) {
      return NotificationPreference.fromHtml(maps[i]['isActive'],
          maps[i]['antecedence'], maps[i]['notificationType']);
    });
  }

  /// Adds all items from [preferences] to this database.
  /// If a row with the same data is present, it will be replaced.
  Future<void> _insertPreferences(
      List<NotificationPreference> preferences) async {
    for (NotificationPreference preference in preferences) {
      await this.insertInDatabase(
        'notification_preferences',
        preference.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<NotificationPreference> getPreference(NotificationType type) async {
    final Database db = await this.getDatabase();

    // This list only contains more than one element if primary key is broken
    final List<Map<String, dynamic>> rawPreferences = await db.query(
        'notification_preferences',
        where: 'notificationType = ?',
        whereArgs: [type.typeName]
    );

    final wantedPreference = rawPreferences[0];
    return NotificationPreference.fromHtml(wantedPreference['isActive'],
        wantedPreference['antecedence'], wantedPreference['notificationType']);
  }

  Future<void> replacePreference(NotificationPreference preference) async {
    final Database db = await this.getDatabase();
    Logger().d("Updating preference: ${preference.toMap()}");
    await db.update(
        'notification_preferences',
        preference.toMap(),
        where: 'notificationType = ?',
        whereArgs: [preference.notificationType]
    );
  }

  /// Deletes all of the data stored in this database.
  Future<void> deletePreferences() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    await db.delete('notification_preferences');
  }
}
