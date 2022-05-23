class MissingNotificationPreferenceException implements Exception {
  String cause;

  MissingNotificationPreferenceException(this.cause);
}
