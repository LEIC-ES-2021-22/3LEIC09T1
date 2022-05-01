import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:redux/redux.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/utils/constants.dart';
import 'package:uni/model/notification.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScheduler {
  Store<AppState> _store;

  NotificationScheduler(this._store);

  static NotificationDetails _buildPlatformChannelSpecifics(Notification notification) {
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        notification.notificationChannel.channelId,
        notification.notificationChannel.channelName,
        notification.notificationChannel.channelDesc,
    );
    return NotificationDetails(android: androidPlatformChannelSpecifics);
  }

  Future<void> schedule(Notification notification, tz.TZDateTime scheduledTime) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      _store.state.content['flutterLocalNotificationsPlugin'];
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        scheduledTime,
        _buildPlatformChannelSpecifics(notification),
        uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true
    );
  }
}