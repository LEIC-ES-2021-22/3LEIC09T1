# 3LEIC09T1

## Team UniNotif

### Members

- Afonso Monteiro (201907284)
- Marcelo Couto (201906086)
- Francisco Oliveira (201907361)
- Rui Moreira (201906355)

## Product Vision

Our project aims to provide members of *Faculdade de Engenharia Universidade do Porto* with a variety of notifications regarding specific events related to their degree, such as classes or tuition payment limits.

As sigarra has no notification system in place, our product aims to differentiate UNI by adding one. We believe this feature will aid the user not to forget events within its interest, as well as improve the app's usability and overall user experience.

### Main Features

- Notifications on the user's schedule;
- Notifications on the payment of tuition fees.

### API's to use

- Student's timetable from sigarra;
- Student's billing information from sigarra.

## Requirements

#### Functional
- The system should send a notification whenever the user has an upcoming class
- The system should send a notification whenever it is getting near the tuition payment due date
- The system should allow the user to edit which notifications he wishes to receive and when

#### Nonfunctional
- The system should be developped using Flutter version 2.0.*
- The system should be available and fully functional for both IOS and Android devices  

### Use Cases

(Use case UML)

#### Notification

|||
| --- | --- |
| *Name* | Notification |
| *Actor* |  Application (UNI) | 
| *Description* | The application creates a notification to notify the user of a certain event. |
| *Preconditions* | A certain event must be near to occur and notifications for this event have to be subscribed |
| *Postconditions* |  |
| *Normal flow* |  |
| *Alternative flows and exceptions* |  |
