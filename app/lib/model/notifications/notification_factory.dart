import 'package:uni/model/notifications/notification.dart';

abstract class NotificationFactory<Model> {
  Notification buildNotification(Model notificationModel);
}
