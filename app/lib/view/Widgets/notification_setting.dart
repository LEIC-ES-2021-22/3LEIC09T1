import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/utils/constants.dart';

class NotificationSetting extends StatelessWidget {
  final NotificationType notificationType;
  final bool switched;
  final double sliderValue;
  final Function(bool) onSwitchChanged;

  NotificationSetting({
    @required this.notificationType,
    @required this.switched,
    @required this.onSwitchChanged,
    @required this.sliderValue
  });

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
