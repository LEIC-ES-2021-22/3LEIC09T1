# 3LEIC09T1

## Team UniNotif

### Members

- Afonso Monteiro (201907284)
- Marcelo Couto (201906086)
- Francisco Oliveira (201907361)
- Rui Moreira (201906355)
- José Costa (202004823)

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

#### Nonfunctional

- The system should be developped using Flutter version 2.0.*
- The system should be available and fully functional for both IOS and Android devices  

### Use Cases

![Use Case UML](img/UseCaseModel.drawio.png)

#### Notification

|||
| --- | --- |
| *Name* | Change tuition payment limit date notifications |
| *Actor* |  User |
| *Description* | The application creates a notification to notify the user of a certain event. |
| *Preconditions* | A certain event must be near to occur and notifications for this event have to be subscribed |
| *Postconditions* | The notification subscription for the specific event expires and the system displays the appropiate notification. |
| *Normal flow* | 1. The system  interprets the appropiate conditions to send a notification.<br>2.  The system displays the appropiate information to the user through a notification. <br> 3. The user presses the notification bar. <br> 4. The system displays the application menu relative to the notification's subject. |
| *Alternative flows and exceptions* | 1. [Optional Use] In step 3 of the normal flow, if the user decides not to press the notification bar, the bar recedes leaving the option offered by step 3 unavailable. <br> 2. [Change failure] If, in step 2 of the normal flow, the information is unobtainable, the system doesn't display the notification |

#### Change class notification parameters

|||
| --- | --- |
| *Name* | Change classes on which notifications are active |
| *Actor* |  User |
| *Description* | The user costumizes the classes on which notifications he wants to be notified a certain time before they occur. |
| *Preconditions* | The user is enrolled in at least one course. |
| *Postconditions* | A new set of notification parameters for class notifications replaces the previously established one. |
| *Normal flow* | 1. The user accesses the notification settings. <br> 2. The user selects the class notifications definitions option. <br> 3. The user selects the option to edit classes with notifications active. <br> 4. Activates/deactivates notifications for each class shown. <br> 5. The system alters the class's notifications settings. |
| *Alternative flows and exceptions* | [No enrolled courses failure] If, after step 2 of the normal flow, the user is not enrolled in the any course, the system displays a message stating that same situation. |
