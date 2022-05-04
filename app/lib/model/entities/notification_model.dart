import 'package:logger/logger.dart';

class NotificationPreference {
  int notificationId;
  int modelId;
  String notificationType;

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'modelId': modelId,
      'notificationType': notificationType,
    };
  }

  factory NotificationPreference.fromHtml(
      int isActive, int antecedence, String notificationType) {
    return NotificationPreference(
        isActive == 1 ? true : false, antecedence, notificationType);
  }

  @override
  String toString() {
    return 'IsActive: ' +
        this.isActive.toString() +
        ' | Antecedence: ' +
        antecedence.toString() +
        ' | Type: ' +
        this.notificationType;
  }
}
