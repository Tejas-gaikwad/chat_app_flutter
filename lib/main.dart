import 'package:chat_app_flutter/features/theme_state/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/start_screen/start_screen.dart';
import 'features/theme_state/bloc/theme_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // PermissionRequestService().requestNotificationPermission();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDfyzPvfEDgh18apko9fIM-1qVk_iIMM0w",
    appId: "1:530584331887:android:728851324420e378328f9a",
    messagingSenderId: "530584331887",
    projectId: "chat-app-flutter-cb1fe",
    // storageBucket:
    //     "chat-app-flutter.appspot.com", //"chat-app-flutter-cb1fe.appspot.com",
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
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(ThemeInitialState()),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        ThemeData theme;
        if (state is ThemeChanged) {
          theme = state.isDarkMode ? darkMode : lightMode;
        } else {
          // Default to light theme if the state is not available yet
          theme = lightMode;
        }

        return const MaterialApp(
          title: 'Chat App',
          home: StartCheckScreen(),
        );
      },
    );
  }
}
