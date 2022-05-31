import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/utils/constants.dart';
import 'package:uni/model/notifications/notification.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  final Store<AppState> _store;

  NotificationScheduler(this._store);

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
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        this._store.state.content['flutterLocalNotificationsPlugin'];
    flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> schedule(
      Notification notification, tz.TZDateTime scheduledTime) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        this._store.state.content['flutterLocalNotificationsPlugin'];
    Logger()
        .i('LocalNotifPlugin:' + flutterLocalNotificationsPlugin.toString());
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        scheduledTime,
        _buildPlatformChannelSpecifics(notification),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future<void> scheduleAll() async {
    final List<NotificationPreference> preferences =
        await this._store.state.content['userNotificationPreferences'];
    Logger().i('Preferences:' + preferences.toString());
  }
}
