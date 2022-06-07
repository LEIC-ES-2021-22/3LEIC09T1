import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/local_storage/app_notification_preferences_database.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/model/schedule_page_model.dart';
import 'package:uni/utils/constants.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Widgets/notification_setting.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/controller/notifications/notification_setup.dart';

class NotificationSettingsPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationSettingsPageViewState();
}

class NotificationSettingsPageViewState extends SecondaryPageViewState {
  bool _editedPreferences = false;
  bool _permanentSession = false;
  final Map<NotificationType, NotificationPreference> notificationSettings = {
    NotificationType.classNotif: NotificationPreference(
        antecedence: 0,
        notificationType: NotificationType.classNotif.typeName,
        isActive: false)
  };

  NotificationSettingsPageViewState() {
    retrievePermanentSession().then((value) => {
          if (_permanentSession) {retrieveSettingsFromDatabase()}
        });
  }

  Future<void> retrieveSettingsFromDatabase() async {
    final db = AppNotificationPreferencesDatabase();
    for (var key in notificationSettings.keys) {
      notificationSettings[key] = await db.getPreference(key);
    }
    if (mounted) {
      setState(() => _editedPreferences = false);
    }
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

  getCommitButtons() {
    if (_editedPreferences) {
      return Padding(
          padding: EdgeInsets.all(10),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
              child: Text('Descartar'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey)),
              onPressed: () {
                retrieveSettingsFromDatabase();
              },
            ),
            SizedBox(width: 15),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: savePreferences,
            ),
          ]));
    }
    return SizedBox.shrink();
  }

  savePreferences() async {
    final db = AppNotificationPreferencesDatabase();
    for (var value in notificationSettings.values) {
      await db.replacePreference(value);
    }
    if (mounted) {
      setState(() => _editedPreferences = false);
    }
    await resetNotifications();
  }

  @override
  Widget getBody(BuildContext context) {
    final Column body = Column(
      children: <Widget>[
        PageTitle(name: 'Notificações'),
        NotificationSetting(
          notificationType: NotificationType.classNotif,
          switched: notificationSettings[NotificationType.classNotif].isActive,
          onSwitchChanged: (value) {
            setState(() {
              _editedPreferences = true;
              notificationSettings[NotificationType.classNotif].isActive =
                  value;
            });
          },
          onSliderChanged: (value) {
            setState(() => _editedPreferences = true);
            notificationSettings[NotificationType.classNotif].antecedence =
                value.toInt();
          },
          initialSliderValue:
              notificationSettings[NotificationType.classNotif].antecedence,
        ),
        getCommitButtons(),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Text('Ver Horário'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SchedulePage()));
            },
          ),
        )
      ],
    );
    final Column noBody = Column(children: <Widget>[
      PageTitle(name: 'Notificações'),
      Align(
        alignment: Alignment.center,
        child: const Text(
            'You need to be in a permanent session to access this feature',
            textAlign: TextAlign.center),
      )
    ]);
    if (_permanentSession) {
      return body;
    } else {
      return noBody;
    }
    return Column(
      children: <Widget>[
        PageTitle(name: 'Notificações'),
        NotificationSetting(
          notificationType: NotificationType.classNotif,
          switched: notificationSettings[NotificationType.classNotif].isActive,
          onSwitchChanged: (value) {
            setState(() {
              _editedPreferences = true;
              notificationSettings[NotificationType.classNotif].isActive =
                  value;
            });
          },
          onSliderChanged: (value) {
            setState(() => _editedPreferences = true);
            notificationSettings[NotificationType.classNotif].antecedence =
                value.toInt();
          },
          initialSliderValue:
              notificationSettings[NotificationType.classNotif].antecedence,
        ),
        getCommitButtons(),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Text('Ver Horário'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SchedulePage()));
            },
          ),
        )
      ],
    );
  }
}
