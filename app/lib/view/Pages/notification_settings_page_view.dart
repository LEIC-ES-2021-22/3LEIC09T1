import 'package:flutter/material.dart';
import 'package:uni/utils/constants.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Widgets/notification_setting.dart';
import 'package:uni/view/Widgets/page_title.dart';

class NotificationSettingsPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationSettingsPageViewState();
}

class NotificationSettingsPageViewState extends SecondaryPageViewState {
  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: <Widget>[
        PageTitle(
          name: 'Notificações'
        ),
        NotificationSetting(
          notificationType: NotificationType.classNotif,
          switched: false,
          onSwitchChanged: (value) {

          },
          sliderValue: 10.0,
        ),
      ],
    );
  }
}
