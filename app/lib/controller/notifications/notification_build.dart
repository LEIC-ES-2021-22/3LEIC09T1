import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:uni/controller/local_storage/app_notification_preferences_database.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/notification_preference.dart';

Future<void> notificationBuild(Store<AppState> store) async {
  final List<NotificationPreference> preferences =
      await store.state.content['userNotificationPreferences'];
  Logger().i('Preferences:' + preferences.toString());
}
