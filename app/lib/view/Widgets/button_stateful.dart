import 'package:flutter/material.dart';

class ScheduleButton extends StatefulWidget {
  final int lectureId;

  ScheduleButton({
    @required this.lectureId
  });

  @override
  ScheduleButtonState createState() => ScheduleButtonState(
    lectureId: this.lectureId
  );
}

class ScheduleButtonState extends State<ScheduleButton> {
  final int lectureId;
  bool notificationActivated = false;

  ScheduleButtonState({
    @required this.lectureId
  });

  void onPressed() {
    //add another function here if needed
    setState(() {
      notificationActivated = !notificationActivated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0.65, 0),
        child: Transform.scale(
            scale: 0.8,
            child: FloatingActionButton(
                onPressed: onPressed,
                child: Icon(
                    notificationActivated ?
                    Icons.alarm_off_rounded :
                    Icons.alarm_add_rounded
                ),
                heroTag: null
            )
        )
    );
  }
}
