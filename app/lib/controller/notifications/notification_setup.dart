import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/local_storage/app_lecture_notification_preferences_database.dart';
import 'package:uni/controller/local_storage/app_lectures_database.dart';
import 'package:uni/controller/local_storage/app_notification_data_database.dart';
import 'package:uni/controller/local_storage/app_notification_preferences_database.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/notifications/notification_scheduler.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/lecture_notification_preference.dart';
import 'package:uni/model/entities/notification_data.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/model/notifications/class_notification_factory.dart';
import 'package:uni/model/notifications/notification.dart';
import 'package:uni/utils/constants.dart';

Future<List<NotificationPreference>> notificationPreferences() async {
  final AppNotificationPreferencesDatabase db =
      AppNotificationPreferencesDatabase();
  List<NotificationPreference> preferences = await db.preferences();
  if (preferences.isEmpty) {
    preferences = [
      NotificationPreference(
          isActive: true,
          antecedence: NotificationPreference.DEFAULT_ANTECEDENCE,
          notificationType: NotificationType.classNotif.typeName)
    ];
    await db.saveNewPreferences(preferences);
  }
  return preferences;
}

Future<List<NotificationData>> notificationsData() async {
  return AppNotificationDataDatabase().notificationsData();
}

Future<List<LectureNotificationPreference>>
    lectureNotificationPreferences() async {
  return AppLectureNotificationPreferencesDatabase().preferences();
}

Future<void> resetNotifications() async {
  NotificationScheduler().unscheduleAll();
  await AppNotificationDataDatabase().deleteNotificationsData();
  await notificationSetUp();
}

Future<void> notificationSetUp() async {
  final Tuple2<String, String> userPersistentInfo =
      await AppSharedPreferences.getPersistentUserInfo();
  if (userPersistentInfo.item1 == '' || userPersistentInfo.item2 == '') return;

  final List<NotificationPreference> preferences =
      await notificationPreferences();
  for (NotificationPreference preference in preferences) {
    if (preference.notificationType == NotificationType.classNotif.typeName &&
        preference.isActive) {
      classNotificationSetUp(preference.antecedence);
    }
  }
}

Future<void> classNotificationSetUp(int antecedence) async {
  final preferences = await lectureNotificationPreferences();
  Logger().i('Lecture preferences:' + preferences.toString());
  final alreadyScheduled = await notificationsData();
  Logger().i('Notification data:' + alreadyScheduled.toString());
  final List<Lecture> lectures = await AppLecturesDatabase().lectures();
  for (Lecture lecture in lectures) {
    if (!shouldScheduleClass(lecture, alreadyScheduled, preferences)) {
      Logger().i(
          'Notification Already Scheduled: ${lecture.subject}-${lecture.day}');
      continue;
    }
    final Notification notification =
        ClassNotificationFactory().buildNotification(lecture);
    alreadyScheduled.add(NotificationData(
        notification.id, lecture.id, NotificationType.classNotif.typeName));
    NotificationScheduler().schedule(notification,
        ClassNotificationFactory().calculateTime(lecture, antecedence));
  }
  AppNotificationDataDatabase().saveNewNotificationData(alreadyScheduled);
}

bool shouldScheduleClass(
    Lecture lecture,
    List<NotificationData> notificationsData,
    List<LectureNotificationPreference> preferences) {
  try {
    return !NotificationData.listContainsModelId(
            notificationsData, lecture.id) &&
        LectureNotificationPreference.idIsActive(preferences, lecture.id);
  } catch (e) {
    Logger().e('Error: ${e.cause}/${lecture.subject}-${lecture.typeClass}-${lecture.day}');
  }
  return false;
}
