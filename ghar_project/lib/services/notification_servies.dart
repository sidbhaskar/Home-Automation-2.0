// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationServies {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize = new AndroidInitializationSettings('homelogo');
//     var iOSInitialize = new 
//   }

//   // Future<void> initNotification() async {
//   //   AndroidInitializationSettings initializationSettingsAndroid =
//   //       const AndroidInitializationSettings('homelogo');

//   //   var initializationSettingsIOS = DarwinInitializationSettings(
//   //       requestAlertPermission: true,
//   //       requestBadgePermission: true,
//   //       requestSoundPermission: true,
//   //       onDidReceiveLocalNotification:
//   //           (int id, String? title, String? body, String? payload) async {});

//   //   var initializationSettings = InitializationSettings(
//   //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   //   await notificationsPlugin.initialize(initializationSettings,
//   //       onDidReceiveNotificationResponse:
//   //           (NotificationResponse notificationResponse) async {});
//   // }

//   // notificationDetails() {
//   //   return const NotificationDetails(
//   //       android: AndroidNotificationDetails('channelId', 'channelName',
//   //           importance: Importance.max),
//   //       iOS: DarwinNotificationDetails());
//   // }

//   // Future showNotification(
//   //     {int id = 0, String? title, String? body, String? payLoad}) async {
//   //   return notificationsPlugin.show(
//   //       id, title, body, await notificationDetails());
//   // }
// }
