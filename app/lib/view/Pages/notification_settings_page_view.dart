import 'package:flutter/material.dart';
import 'package:uni/controller/local_storage/app_notification_preferences_database.dart';
import 'package:uni/model/entities/notification_preference.dart';
import 'package:uni/model/schedule_page_model.dart';
import 'package:uni/utils/constants.dart';
import 'package:uni/view/Pages/schedule_page_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Widgets/notification_setting.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/controller/notifications/notification_setup.dart';

class NotificationSettingsPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationSettingsPageViewState();
}

class NotificationSettingsPageViewState extends SecondaryPageViewState {
  var _editedPreferences = false;
  final Map<NotificationType, NotificationPreference> notificationSettings = {
    NotificationType.classNotif: NotificationPreference(
        antecedence: 0,
        notificationType: NotificationType.classNotif.typeName,
        isActive: false)
  };

  NotificationSettingsPageViewState() {
    retrieveSettingsFromDatabase();
  }

  retrieveSettingsFromDatabase() async {
    final db = AppNotificationPreferencesDatabase();
    for (var key in notificationSettings.keys) {
      notificationSettings[key] = await db.getPreference(key);
    }
    if (mounted) {
      setState(() => _editedPreferences = false);
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
