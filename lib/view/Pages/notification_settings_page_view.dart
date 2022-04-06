import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

class NotificationSettingsPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationSettingsPageViewState();
}

/// Manages the 'Bugs and sugestions' section of the app.
class NotificationSettingsPageViewState extends SecondaryPageViewState {
  bool isSwitched = false;

  @override
  Widget getBody(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Switch(
          value: isSwitched,
          onChanged: (newState) {
            setState(() {
              isSwitched = newState;
            });
          },
        ),
        Text()
      ],
    ));
  }
}
