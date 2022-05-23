import 'package:logger/logger.dart';
import 'package:uni/utils/constants.dart';

class NotificationData {
  int notificationId;
  int modelId;
  String notificationType;

  NotificationData(this.notificationId, this.modelId, this.notificationType);

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'modelId': modelId,
      'notificationType': notificationType,
    };
  }

  factory NotificationData.fromHtml(
      int notificationId, int modelId, String notificationType) {
    return NotificationData(notificationId, modelId, notificationType);
  }

  @override
  String toString() {
    return 'NotificationId:' +
        this.notificationId.toString() +
        ' | ModelId:' +
        modelId.toString() +
        ' | Type:' +
        this.notificationType;
  }

  static bool listContainsModelId(
      List<NotificationData> notificationData, int modelId) {
    for (NotificationData data in notificationData) {
      if (data.modelId == modelId) return true;
    }
    return false;
  }
}
