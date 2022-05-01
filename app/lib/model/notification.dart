import 'package:uni/utils/constants.dart';

class Notification {
  int id;
  String body;
  String title;
  NotificationChannel notificationChannel;

  Notification(this.id, this.body, this.title, this.notificationChannel);
}