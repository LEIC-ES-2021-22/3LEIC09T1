import 'package:uni/controller/local_storage/app_notification_preferences_database.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:workmanager/workmanager.dart';
import 'package:uni/utils/constants.dart';

class ClassNotificationScheduleTask {
  static const String taskId = 'ClassNotificationScheduleTask';

  static Future<void> createClassNotificationSchedulingJob() async {
    if (!await AppSharedPreferences.classNotificationJobCreated()) {
      Workmanager().registerPeriodicTask(
          taskId,
          taskId,
          frequency: Duration(days: 7),

      );
      // Cancels the task in case mobile data is deleted
      await Workmanager().cancelByUniqueName(taskId);
      await AppSharedPreferences.setClassNotificationJobCreated(true);
    }
  }

  static void scheduleClassNotifications() async {
    List<NotificationPreference> notificationsTurnedOn =
      await AppNotificationPreferencesDatabase()
          .preferencesByType(NotificationType.classNotif.channelId);
  }
}
