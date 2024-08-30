part of '../custompushnotification.dart';

class CustomPushNotificationMessages {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final BuildContext context;
  String? routeName;
  String? notificationIcon;

  CustomPushNotificationMessages({
    required this.context,
    this.routeName,
    this.notificationIcon,
  }) {
    // To listen to messages when  application is in the foreground

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    // To listen to messages when application is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      _navigateToScreen();
    });

    _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
  }

  Future<dynamic> onSelectNotification(
    String? payload,
  ) async {
    /*Do whatever you want to do on notification click. */

    _navigateToScreen();
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              'channel_ID', 'used for push notification only',
              channelDescription: 'used for push notification only',
              icon: notificationIcon ?? '@mipmap/ic_launcher',
              importance: Importance.high,
              playSound: true,
              showProgress: true,
              priority: Priority.max,
              ticker: 'minebrat ticker'),
        ),
      );
    }
  }

  Future _navigateToScreen() async {
    Navigator.pushNamed(
      context,
      routeName!,
    );
  }
}
