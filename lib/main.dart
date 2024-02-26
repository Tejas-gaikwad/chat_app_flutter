import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'features/start_screen/start_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // PermissionRequestService().requestNotificationPermission();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDfyzPvfEDgh18apko9fIM-1qVk_iIMM0w",
    appId: "1:530584331887:android:728851324420e378328f9a",
    messagingSenderId: "530584331887",
    projectId: "chat-app-flutter-cb1fe",
    storageBucket: "chat_app_flutter.appspot.com",
  ));
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {}

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartCheckScreen(),
    );
  }
}
