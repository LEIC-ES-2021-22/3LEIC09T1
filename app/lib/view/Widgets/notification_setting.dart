import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/controller/local_storage/app_notification_preferences_database.dart';
import 'package:uni/model/entities/notification_preference.dart';

class NotificationSetting extends StatefulWidget {
  String _notificationName;
  bool _switched;
  Function(bool) _onChanged;

  NotificationSetting(String notificationName,
      {bool switched, Function(bool) onChanged}) {
    this._notificationName = notificationName;
    this._switched = switched;
    this._onChanged = onChanged;
  }

  @override
  State<NotificationSetting> createState() =>
      _NotificationSettingsState(_notificationName,
          switched: _switched, onChanged: _onChanged);
}

class _NotificationSettingsState extends State<NotificationSetting> {
  String _notificationName;
  bool _switched;
  Function(bool) _onChanged;
  List<NotificationPreference> current = AppNotificationPreferencesDatabase()
      .preferences() as List<NotificationPreference>;

  double _timerSliderValue; // Class notification

  _NotificationSettingsState(String notificationName,
      {bool switched, Function(bool) onChanged}) {
    this._notificationName = notificationName;
    this._switched = switched;
    this._onChanged = onChanged;
    this._timerSliderValue = current[current.indexWhere(
            (element) => element.notificationType == _notificationName)]
        .antecedence
        .toDouble();
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
          min: 0,
          max: 100,
          divisions: 20,
          //label: _timerSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _timerSliderValue = value.roundToDouble();
              //the round fixes weird glitch when the value hits 55
            });
          },
          activeColor: Colors.brown[300],
          inactiveColor: Colors.deepOrange[400],
        ),
      );
      columnChildren.add(
        SizedBox(height: 30),
      );
      if (_notificationName == 'Início de Aulas') {
        columnChildren
            .add(Text("$_timerSliderValue minutos antes da próxima aula."));
      } else {
        columnChildren.add(Text(
            "$_timerSliderValue dias antes do prazo do próximo pagamento."));
      }

      // Only consider active if the slider is set to a value greater than 0
      bool _active = _timerSliderValue.round() > 0;
      if (_active) {
        //New preference
        NotificationPreference _pref = NotificationPreference(
            _active, _timerSliderValue.round(), _notificationName);

        //Access database
        AppNotificationPreferencesDatabase _db =
            AppNotificationPreferencesDatabase();

        //Update the preference list
        Future<List<NotificationPreference>> _preflst = _db.preferences();
        List<NotificationPreference> _preferences =
            _preflst as List<NotificationPreference>;
        //search and update the preference
        _preferences[_preferences.indexWhere(
                (element) => element.notificationType == _notificationName)] =
            _pref;
        _db.saveNewPreferences(_preferences);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: columnChildren),
    );
  }
}
