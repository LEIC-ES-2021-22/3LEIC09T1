import 'package:uni/utils/constants.dart';

class Notification {
  int id;
  String body;
  String title;
  NotificationType notificationChannel;

  Notification(this.id, this.body, this.title, this.notificationChannel);

  @override
  String toString() {
    return 'ID:' +
        this.id.toString() +
        '  Title:' +
        this.title +
        '  Body:' +
        this.body;
  }
}
