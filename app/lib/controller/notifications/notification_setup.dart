import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/notifications/notification_scheduler.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/model/notifications/class_notification_factory.dart';
import 'package:uni/model/notifications/notification.dart';
import 'package:uni/model/notifications/notification_factory.dart';

Future<void> notificationBuild(Store<AppState> store) async {
  final Tuple2<String, String> userPersistentInfo =
      await AppSharedPreferences.getPersistentUserInfo();
  if (userPersistentInfo.item1 == '' || userPersistentInfo.item2 == '') return;

  final List<NotificationPreference> preferences =
      store.state.content['userNotificationPreferences'];
  for (NotificationPreference preference in preferences) {
    if (preference.notificationType == 'classNotification' &&
        preference.isActive) {
      classNotificationBuild(store, preference.antecedence);
    }
  }
}

Future<void> classNotificationBuild(
    Store<AppState> store, int antecedence) async {
  final List<Lecture> lectures = store.state.content['schedule'];
  for (Lecture lecture in lectures) {
    //TODO: finish scheduling implementation
    Notification notification =
        ClassNotificationFactory().buildNotification(lecture);
    // NotificationScheduler(store).schedule(notification, );
  }
}
