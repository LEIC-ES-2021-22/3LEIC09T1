import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/local_storage/app_lectures_database.dart';
import 'package:uni/controller/local_storage/app_notification_data_database.dart';
import 'package:uni/controller/local_storage/app_notification_preferences_database.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/notifications/notification_scheduler.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/notification_data.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/model/notifications/class_notification_factory.dart';

Future<List<NotificationPreference>> notificationPreferences() async {
  final AppNotificationPreferencesDatabase db =
      AppNotificationPreferencesDatabase();
  List<NotificationPreference> preferences = await db.preferences();
  if (preferences.isEmpty) {
    preferences = [NotificationPreference(true, 10, 'classNotification')];
    await db.saveNewPreferences(preferences);
  }
  return preferences;
}

Future<List<NotificationData>> notificationsData() async {
  return AppNotificationDataDatabase().notificationsData();
}

Future<void> notificationSetUp(Store<AppState> store) async {
  final Tuple2<String, String> userPersistentInfo =
      await AppSharedPreferences.getPersistentUserInfo();
  if (userPersistentInfo.item1 == '' || userPersistentInfo.item2 == '') return;

  final List<NotificationPreference> preferences =
      await notificationPreferences();
  Logger().i('Preferences:' + preferences.toString());
  for (NotificationPreference preference in preferences) {
    if (preference.notificationType == 'classNotification' &&
        preference.isActive) {
      classNotificationSetUp(store, preference.antecedence);
    }
  }
}

Future<void> classNotificationSetUp(
    Store<AppState> store, int antecedence) async {
  final List<Lecture> lectures = await AppLecturesDatabase().lectures();
  for (Lecture lecture in lectures) {
    NotificationScheduler(store).schedule(
        ClassNotificationFactory().buildNotification(lecture),
        ClassNotificationFactory().calculateTime(lecture, antecedence));
  }
}
