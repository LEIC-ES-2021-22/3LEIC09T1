import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Widgets/notification_setting.dart';
import 'package:uni/view/Widgets/page_title.dart';

class NotificationSettingsPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationSettingsPageViewState();
}

/// Manages the 'Bugs and sugestions' section of the app.
class NotificationSettingsPageViewState extends SecondaryPageViewState {
  List<bool> _isOpen = List.filled(2, false);

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: <Widget>[
        PageTitle(
          name: 'Notificações'
        ),
        NotificationSetting(
          'Início de Aulas',
          switched: _isOpen[0],
          onChanged: (newState) { 
            setState(() => _isOpen[0] = newState);
          },
        ),
        NotificationSetting(
          'Pagamento de propinas',
          switched: _isOpen[1],
          onChanged: (newState) { 
            setState(() => _isOpen[1] = newState);
          },
        )
      ],
    );
  }
}
