import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_Screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';

void main() async {
  const apiKey = "AIzaSyDmE17h0n1HKvnrrSuXr_9JdP-qsyLuvQ8";
  const appId = "1:336221982175:web:682c3f03d843025628086a";
  const messagingSenderId = "336221982175";
  const projectId = "instagram-tut-d2d71";
  const storageBucket = "instagram-tut-d2d71.appspot.com";
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: apiKey,
        appId: appId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        storageBucket: storageBucket,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      //lt copy with rende responsive
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: const LoginScreen(),
    );
  }
}
