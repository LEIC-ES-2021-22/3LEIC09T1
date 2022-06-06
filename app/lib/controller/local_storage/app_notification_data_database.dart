import 'dart:async';
import 'package:logger/logger.dart';
import 'package:uni/controller/local_storage/app_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uni/model/entities/notification_data.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/model/notifications/notification.dart';
import 'package:uni/utils/constants.dart';

/// Manages the app's Notifications Data database.
///
/// This database stores information about notifications data.
/// See the [NotificationData] class to see what is stored.
class AppNotificationDataDatabase extends AppDatabase {
  static final createScript =
      '''CREATE TABLE notification_data(notificationId INTEGER PRIMARY KEY, modelId INTEGER NOT NULL UNIQUE, notificationType TEXT NOT NULL)''';

  AppNotificationDataDatabase()
      : super(
            'notification_data.db',
            [
              createScript,
            ],
            version: 1);

  /// Replaces all of the data in this database with [notificationsData].
  saveNewNotificationData(List<NotificationData> notificationsData) async {
    await deleteNotificationsData();
    await _insertNotificationsData(notificationsData);
  }

  /// Returns a list containing all of the notifications data stored in this database.
  Future<List<NotificationData>> notificationsData() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    // Query the table for All The Preferences.
    final List<Map<String, dynamic>> maps = await db.query('notification_data');

    // Convert the List<Map<String, dynamic>
    // into a List<NotificationData>.
    return List.generate(maps.length, (i) {
      return NotificationData.fromHtml(maps[i]['notificationId'],
          maps[i]['modelId'], maps[i]['notificationType']);
    });
  }

  /// Adds all items from [notificationsData] to this database.
  /// If a row with the same data is present, it will be replaced.
  Future<void> _insertNotificationsData(
      List<NotificationData> notificationsData) async {
    for (NotificationData data in notificationsData) {
      await this.insertInDatabase(
        'notification_data',
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Deletes all of the data stored in this database.
  Future<void> deleteNotificationsData() async {
    // Get a reference to the database
    final Database db = await this.getDatabase();

    await db.delete('notification_data');
  }
}
