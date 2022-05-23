import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

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

  }
}
