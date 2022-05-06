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

extension NotificationTypeData on NotificationType {
  static const channelIds = {
    NotificationType.classNotif: '0',
    NotificationType.tuitionNotif: '1'
  };

  static const channelNames = {
    NotificationType.classNotif: 'Notificações de Aulas',
    NotificationType.tuitionNotif: 'Notificações de Pagamento de propinas'
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
}
