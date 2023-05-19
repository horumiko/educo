import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_course/screens/account.dart';
import 'package:online_course/screens/home.dart';
import 'screens/root_app.dart';
import 'theme/color.dart';
import 'package:online_course/screens/login_screen.dart';
import 'package:online_course/screens/reset_password_screen.dart';
import 'package:online_course/screens/signup_screen.dart';
import 'package:online_course/screens/verify_email_screen.dart';
import 'package:online_course/services/firebase_streem.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduCo',
      theme: ThemeData(
        primaryColor: primary,
      ),
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => const RootApp(),
        '/account': (context) => const AccountPage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/verify_email': (context) => const VerifyEmailScreen(),
      },
      initialRoute: '/login',
    );
  }
}