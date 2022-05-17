import 'package:logger/logger.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/notifications/notification.dart';
import 'package:uni/model/notifications/notification_factory.dart';
import 'package:uni/utils/constants.dart';
import 'package:timezone/timezone.dart' as tz;

class ClassNotificationFactory extends NotificationFactory<Lecture> {
  @override
  Notification buildNotification(Lecture notificationModel) {
    final String title = 'Aula a começar: ' + notificationModel.subject;
    final String body = 'UC: ' +
        notificationModel.subject +
        ' - Tipo: ' +
        notificationModel.typeClass +
        ' - Sala: ' +
        notificationModel.room;

    return Notification(
        notificationModel.id, body, title, NotificationType.classNotif);
  }

  tz.TZDateTime calculateTime(Lecture notificationModel, int antecedence) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final int distance = ((notificationModel.day + 1) % 7 - now.weekday) % 7;
    final tz.TZDateTime date =
        tz.TZDateTime(tz.local, now.year, now.month, now.day)
            .add(Duration(days: distance))
            .add(Duration(hours: notificationModel.startTimeHours))
            .add(Duration(
                minutes: notificationModel.startTimeMinutes - antecedence));
    return date;
  }
}
