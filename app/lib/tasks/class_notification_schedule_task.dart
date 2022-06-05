import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:redux/redux.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/controller/notifications/notification_setup.dart';
import 'package:uni/utils/time_zone_utils.dart';
import 'package:timezone/timezone.dart' as tz;

class ClassNotificationScheduleTask {
  static const String taskId = 'ClassNotificationScheduleTask';

  static Future<void> createClassNotificationSchedulingJob() async {
    if (!await AppSharedPreferences.classNotificationJobCreated()) {
      Workmanager().registerPeriodicTask(
          taskId,
          taskId,
          frequency: Duration(days: 7),
          // Delays initial job to sunday
          initialDelay: Duration(
              days: delayBetweenDays(
              now: tz.TZDateTime.now(tz.local),
              indexDayOfWeek: 5)
          )
      );
      // Cancels the task in case mobile data is deleted
      await Workmanager().cancelByUniqueName(taskId);
      await AppSharedPreferences.setClassNotificationJobCreated(true);
    }
  }

  static void scheduleClassNotifications(Store<AppState> store) async {
    await notificationSetUp(store);
  }
}
