import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('🔔 Mensaje en background: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _token = '';

  @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  void _setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Notificaciones permitidas');
    }

    _token = await messaging.getToken();
    print('📲 Token: $_token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('👀 Mensaje recibido en foreground: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📂 App abierta desde notificación');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notificaciones',
      home: Scaffold(
        appBar: AppBar(title: const Text('Push Notifications')),
        body: Center(child: Text('Token:\n${_token ?? "Cargando..."}')),
      ),
    );
  }
}
