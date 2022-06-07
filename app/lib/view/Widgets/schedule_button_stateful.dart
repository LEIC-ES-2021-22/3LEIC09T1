import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/local_storage/app_lecture_notification_preferences_database.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/notifications/notification_setup.dart';

class ScheduleButton extends StatefulWidget {
  final int lectureId;

  ScheduleButton({@required this.lectureId});

  @override
  ScheduleButtonState createState() =>
      ScheduleButtonState(lectureId: this.lectureId);
}

class ScheduleButtonState extends State<ScheduleButton> {
  final int lectureId;
  bool _notificationActivated = false;
  bool _permanentSession = false;

  ScheduleButtonState({@required this.lectureId}) {
    retrievePermanentSession().then((value) => {
          if (_permanentSession) {retrieveActivationStatus()}
        });
  }

  Future<void> retrievePermanentSession() async {
    final Tuple2<String, String> userPersistentInfo =
        await AppSharedPreferences.getPersistentUserInfo();
    if (mounted) {
      if (userPersistentInfo.item1 == '' || userPersistentInfo.item2 == '') {
        setState(() => _permanentSession = false);
      } else {
        setState(() => _permanentSession = true);
      }
    }
  }

  Future<void> retrieveActivationStatus() async {
    final bool notificationActivated =
        await AppLectureNotificationPreferencesDatabase()
            .getNotificationPreference(lectureId);
    if (mounted) {
      setState(() {
        _notificationActivated = notificationActivated;
      });
    }
  }

  void onPressed() {
    if (!_permanentSession) return;
    setState(() {
      _notificationActivated = !_notificationActivated;
    });
    AppLectureNotificationPreferencesDatabase()
        .setNotificationPreference(lectureId, _notificationActivated);
    resetNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0.65, 0),
        child: Transform.scale(
            scale: 0.8,
            child: FloatingActionButton(
                onPressed: onPressed,
                child: Icon(_notificationActivated
                    ? Icons.alarm_add_rounded
                    : Icons.alarm_off_rounded),
                heroTag: null)));
  }
}
