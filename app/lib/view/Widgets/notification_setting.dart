import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/utils/constants.dart';

class NotificationSetting extends StatefulWidget {
  final NotificationType notificationType;
  final bool switched;
  final int initialSliderValue;
  final Function(bool) onSwitchChanged;
  final Function(double) onSliderChanged;

  NotificationSetting({
    @required this.notificationType,
    @required this.switched,
    @required this.onSwitchChanged,
    @required this.onSliderChanged,
    @required this.initialSliderValue
  });

  @override
  State<NotificationSetting> createState() => _NotificationSettingState(
      notificationType: this.notificationType,
      switched: this.switched,
      onSwitchChanged: this.onSwitchChanged,
      onSliderChanged: this.onSliderChanged,
      initialSliderValue: this.initialSliderValue
  );
}

class _NotificationSettingState extends State<NotificationSetting> {
  final NotificationType notificationType;
  final bool switched;
  final int initialSliderValue;
  final Function(bool) onSwitchChanged;
  final Function(double) onSliderChanged;
  double sliderValue;

  _NotificationSettingState({
    @required this.notificationType,
    @required this.switched,
    @required this.onSwitchChanged,
    @required this.onSliderChanged,
    @required this.initialSliderValue
  }) {
    sliderValue = initialSliderValue.toDouble();
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(notificationType.channelName),
          Switch(
            value: switched,
            onChanged: onSwitchChanged,
          ),
        ],
      ),
    ];

    if (switched) {
      columnChildren.add(
        Slider(
          value: sliderValue,
          min: 0,
          max: notificationType.antecedenceMaxValue,
          divisions: notificationType.antecedenceGranularity,
          activeColor: Colors.brown[300],
          inactiveColor: Colors.deepOrange[400],
          onChanged: (value) => setState(() => sliderValue = value),
          onChangeEnd: onSliderChanged,
        ),
      );
      columnChildren.add(
        SizedBox(height: 30),
      );
      columnChildren
          .add(Text('$sliderValue ${notificationType.antecedenceSuffix}'));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: columnChildren),
    );
  }
}
