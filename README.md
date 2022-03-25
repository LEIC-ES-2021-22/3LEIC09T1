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

### Use Cases

![Use case model](img/UseCaseModel.png)

#### Deactivate tuition fee payment limit notification

| *Name* | Deactivate tuition fee payment limit notification |
|---|---|
| *Actor* | User |
| *Description* | The user deactivates notifications that are triggered when the payment limit for tuition fees is near |
| *Preconditions* | The user is logged in and has tuition fee notifications activated |
| *Postconditions* | The referred notification type is deactivated |
| *Normal flow* |  1. The user accesses his notification's settings. <br>    2. The system displays a list of notification types. <br>    3. The user selects "Tuition Fee Payment Limit". <br>   4. The user slides a slider that deactivates that type of notification. |
| *Alternative flows and exceptions* | 1. [No Degree Exception] If, in step 3 the user is not enrolled in degree, the option to select this kind of notification is omitted |


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


### Business rules

- The system should be developped using Flutter version 2.0.*
- The system should be available and fully functional for both IOS and Android devices  
