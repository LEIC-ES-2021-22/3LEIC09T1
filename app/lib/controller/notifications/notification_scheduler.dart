import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/utils/constants.dart';
import 'package:uni/model/notifications/notification.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  static var _notificationPlugin = null;

  static get notificationPlugin {
    return _notificationPlugin;
  }

  NotificationScheduler() {
    if (_notificationPlugin == null) {
      throw Exception(
          'Instantiated Notification Scheduler without initializing it');
    }
  }

  static init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    _notificationPlugin = FlutterLocalNotificationsPlugin();
    await _notificationPlugin.initialize(initializationSettings);
  }

  static NotificationDetails _buildPlatformChannelSpecifics(
      Notification notification) {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      notification.notificationChannel.channelId,
      notification.notificationChannel.channelName,
      notification.notificationChannel.channelDesc,
    );
    return NotificationDetails(android: androidPlatformChannelSpecifics);
  }

  Future<void> unscheduleAll() async {
    NotificationScheduler._notificationPlugin.cancelAll();
  }

  Future<void> schedule(
      Notification notification, tz.TZDateTime scheduledTime) async {
    Logger().i(
        "Scheduled Notification '${notification.toString()}' to '${scheduledTime.toString()}' ");
    await _notificationPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      scheduledTime,
      _buildPlatformChannelSpecifics(notification),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
    );
  }
}
