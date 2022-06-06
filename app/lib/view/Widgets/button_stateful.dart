import 'package:flutter/material.dart';

class ScheduleButton extends StatefulWidget {
  @override
  ScheduleButtonState createState() => new ScheduleButtonState();
}

class ScheduleButtonState extends State<ScheduleButton> {
  int fabIconNumber = 0;
  List<IconData> icons = [Icons.alarm_off_rounded, Icons.alarm_add_rounded];
  IconData ic = Icons.alarm_add_rounded;

  void onPressed() {
    //add another function here if needed
    setState(() {
      fabIconNumber = fabIconNumber % 2 == 0 ? 0 : 1;
      ic = icons[fabIconNumber];
      fabIconNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Align(
        alignment: new Alignment(0.65, 0),
        child: new Transform.scale(
            scale: 0.8,
            child: new FloatingActionButton(
                onPressed: onPressed, child: Icon(ic), heroTag: null)));
  }
}
