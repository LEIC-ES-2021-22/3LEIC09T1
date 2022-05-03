import 'package:uni/model/notifications/notification.dart';

abstract class NotificationFactory<Model> {
  Model notificationInformation;

  Notification buildNotification(Model notificationModel);
}
