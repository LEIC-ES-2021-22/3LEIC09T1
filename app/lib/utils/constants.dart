library Constants;

const navPersonalArea = 'Área Pessoal';
const navSchedule = 'Horário';
const navExams = 'Mapa de Exames';
const navStops = 'Autocarros';
const navAbout = 'Sobre';
const navBugReport = 'Bugs e Sugestões';
const navLogOut = 'Terminar sessão';
const navNotificationArea = 'Notificações';

const faculties = [
  'faup',
  'fbaup',
  'fcup',
  'fcnaup',
  'fadeup',
  'fdup',
  'fep',
  'feup',
  'ffup',
  'flup',
  'fmup',
  'fmdup',
  'fpceup',
  'icbas'
];

enum NotificationType { classNotif, tuitionNotif }

extension NotificationWidgetData on NotificationType {
  static const notificationAntecedenceMaxValues = {
    NotificationType.classNotif: 30.0
  };
  static const notificationAntecedenceGranularities = {
    NotificationType.classNotif: 5
  };

  static const notificationAntecedenceSuffixes = {
    NotificationType.classNotif: 'minutos antes da próxima aula.'
  };

  double get antecedenceMaxValue => notificationAntecedenceMaxValues[this];
  int get antecedenceGranularity => notificationAntecedenceGranularities[this];
  String get antecedenceSuffix => notificationAntecedenceSuffixes[this];
}

extension NotificationTypeData on NotificationType {
  static const typeNames = {
    NotificationType.classNotif: 'class notification',
    NotificationType.tuitionNotif: 'tuition notification'
  };

  static const channelIds = {
    NotificationType.classNotif: '0',
    NotificationType.tuitionNotif: '1'
  };

  static const channelNames = {
    NotificationType.classNotif: 'Notificações sobre Aulas',
    NotificationType.tuitionNotif: 'Notificações sobre Pagamento de propinas'
  };

  static const channelDescriptions = {
    NotificationType.classNotif:
        'Informam a hora e sala em que decorrerão as próximas aulas',
    NotificationType.tuitionNotif:
        'Informam a data da próxima propina a ser paga'
  };

  String get channelName => channelNames[this];
  String get channelId => channelIds[this];
  String get channelDesc => channelDescriptions[this];
  String get typeName => typeNames[this];
}
