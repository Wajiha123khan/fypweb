import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/provider/notification_pro.dart';
import 'package:classchronicalapp/provider/teacher_pro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/splash/splash_screen.dart';

import 'provider/degree_pro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    const MyApp(),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("message.notification!.title.toString()");
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthPro>(
          create: (_) => AuthPro(),
        ),
        ChangeNotifierProvider<TeacherPro>(
          create: (_) => TeacherPro(),
        ),
        ChangeNotifierProvider<DegreePro>(
          create: (_) => DegreePro(),
        ),
        ChangeNotifierProvider<NotificationPro>(
          create: (_) => NotificationPro(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Class Chronical App',
        theme: ThemeData(
          primarySwatch: Palette.themecolor,
        ),
        home: const SplashScreen(),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}
