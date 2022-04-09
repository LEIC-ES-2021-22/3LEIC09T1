import 'package:flutter/material.dart';

class NotificationSetting extends StatefulWidget {
  String _notificationName;
  bool _switched;
  Function(bool) _onChanged;


  NotificationSetting(String notificationName, {bool switched, Function(bool) onChanged}) {
    this._notificationName = notificationName;
    this._switched = switched;
    this._onChanged = onChanged;
  }

  @override
  State<NotificationSetting> createState() => _NotificationSettingsState(_notificationName, switched: _switched, onChanged: _onChanged);
}

class _NotificationSettingsState extends State<NotificationSetting> {
  String _notificationName;
  bool _switched;
  Function(bool) _onChanged;
  double _timerSliderValue = 0;

  _NotificationSettingsState(String notificationName, {bool switched, Function(bool) onChanged}) {
    this._notificationName = notificationName;
    this._switched = switched;
    this._onChanged = onChanged;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_notificationName),
          Switch(
            value: _switched,
            onChanged: _onChanged,
          ),
        ],
      ),
    ];

    if (_switched) {
      columnChildren.add(
        Slider(
          value: _timerSliderValue,
          max: 100,
          divisions: 5,
          label: _timerSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _timerSliderValue = value;
            });
          },
        )
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: columnChildren
      ),
    );
  }
}