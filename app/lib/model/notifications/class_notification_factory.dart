import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/notifications/notification.dart';
import 'package:uni/model/notifications/notification_factory.dart';
import 'package:uni/utils/constants.dart';
import 'package:uni/utils/time_zone_utils.dart' as tzu;
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
    return tzu.calculateNextDay(
        now: tz.TZDateTime.now(tz.local),
        indexDayOfWeek: notificationModel.day,
        antecedence: Duration(minutes: antecedence),
        startTimeHours: notificationModel.startTimeHours,
        startTimeMinutes: notificationModel.startTimeMinutes
    );
  }
}
