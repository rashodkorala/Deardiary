import 'package:deardiary/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '/view/diary_login_view.dart';
import '/view/diary_signup_view.dart';
import 'package:flutter/material.dart';
import 'view/diary_forgot_passowrd_view.dart';
import 'view/diary_log_view.dart';
import 'view/diary_entry_view.dart';
import 'view/diary_statistics_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dear Diary',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: WelcomePage(),
      routes: {
        '/diaryLogView': (context) => const DiaryLogView(),
        '/diaryEntryView': (context) => DiaryEntryView(),
        '/loginView': (context) => LoginView(),
        '/signupView': (context) => SignupView(),
        '/forgotPasswordView': (context) => ForgotPasswordView(),
        '/diaryStatisticView': (context) => DiaryStatisticView(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      // Check if there is a user (logged in)
      if (FirebaseAuth.instance.currentUser != null) {
        // User is logged in, navigate to DiaryLogView
        Navigator.pushReplacementNamed(context, '/diaryLogView');
      } else {
        // User is not logged in, navigate to LoginView
        Navigator.pushReplacementNamed(context, '/loginView');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.book,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 20),
            Text(
              'Dear Diary',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            // You can remove the "Get Started" button
          ],
        ),
      ),
    );
  }
}
