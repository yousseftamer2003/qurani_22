import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessageInBackgroundHandler(RemoteMessage message) async {
  await NotificationsController.instance.setupNotifications();
  await NotificationsController.instance.showNotifications(message);
}

class NotificationsController {
  NotificationsController._();
  static final instance = NotificationsController._();

  String fcmToken = '';

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool isLocalNotificationEnabled = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessageInBackgroundHandler);
    await _requestPermission();
    await _setupMessageHandlers();

    fcmToken = await _messaging.getToken() ?? '';
    log('FCM Token: $fcmToken');
    tz.initializeTimeZones();
    final String currentTimeZoneyName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZoneyName));
    await setupNotifications();
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('Permission Status: ${settings.authorizationStatus}');
  }

  Future<void> setupNotifications() async {
  if (isLocalNotificationEnabled) {
    return;
  }

  const channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  const AndroidNotificationChannel azanChannel = AndroidNotificationChannel(
  'azan_notfi_id',
  'azan notfi',
  description: 'This channel is used for azan notifications.',
  importance: Importance.max,
  sound: RawResourceAndroidNotificationSound('azan'),
  playSound: true,
);

  await _localNotifications.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();

  await _localNotifications
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

      await _localNotifications
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(azanChannel);

  const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  const initializationSettingsDarwin = DarwinInitializationSettings();

  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await _localNotifications.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap or action here
      log('Notification payload: ${response.payload}');
    },
  );

  isLocalNotificationEnabled = true;
}

Future<void> showNotifications(RemoteMessage message) async{
  RemoteNotification? notification = message.notification;
  AndroidNotification? androidNotification = message.notification?.android;

  if(notification != null && androidNotification != null){
    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription: 'This channel is used for important notifications.',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data.toString(),
    );
  }
}


Future<void> _setupMessageHandlers() async{
  //foreground message from firebase
  FirebaseMessaging.onMessage.listen((message){
    showNotifications(message);
  });

  //background message from firebase
  FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

  // opened app
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if(initialMessage != null){
    _handleBackgroundMessage(initialMessage);
  }
}

void _handleBackgroundMessage(RemoteMessage message) {
  if(message.data['type'] == 'notification'){
    log('$message');
  }
}

Future<void> sendFcmToBackEnd() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString('app_uuid');
  try {
    final response = await http.post(Uri.parse('https://talk-to-quran.com/api/user/addFCM'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Device-UUID': uuid!,
    },
    body: jsonEncode({
      'fcm_token': fcmToken
    })
    );
    if(response.statusCode == 200){
      log('fcm sent to back end');
    }else{
      log('error sending fcm to back end: ${response.statusCode}');
      log('error sending fcm to back end: ${response.body}');
    }
  } catch (e) {
    log('failed to send fcm to back end: $e');  
  }
}

Future<void> pushNotifications({required String title, required String body}) async{
  try {
    final response = await http.post(Uri.parse('https://talk-to-quran.com/api/notification/broadcast'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'title': title,
      'body': body
    })
    );
    if(response.statusCode == 200){
      log('notifications pushed');
    }else{
      log('error pushing notifications: ${response.statusCode}');
      log('error pushing notifications: ${response.body}');
    }
  } catch (e) {
    log('Error pushing notifications: $e');
  }
}

Future<void> schduleNotification({
  int id =1,
  required String title,
  required String body,
  required int hour,
  required int minute,
}) async{
  final now = tz.TZDateTime.now(tz.local);

  var scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );

  if (scheduledDate.isBefore(now)) {
  scheduledDate = scheduledDate.add(const Duration(days: 1));
}

  await _localNotifications.zonedSchedule(
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    id,
    title,
    body,
    scheduledDate,
    const NotificationDetails(
    android: AndroidNotificationDetails(
      'azan_notfi_id',
      'azan notfi',
      channelDescription: 'This channel is used for azan notifications.',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('azan'),
      playSound: true,
    ),
    iOS: DarwinNotificationDetails(
      sound: 'azan.wav',
      presentSound: true,
    ),
  ),
    matchDateTimeComponents: DateTimeComponents.time,
  );
  log('scheduled notification');
}

Future<void> cancelNotification() async{
  await _localNotifications.cancelAll();
}
}