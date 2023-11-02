import 'package:flutter/material.dart';
import 'controller/diary_controller.dart';
import 'view/diary_log_view.dart';
import 'view/diary_entry_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final diaryController = DiaryController();
  await diaryController.init();
  runApp(MyApp(diaryController: diaryController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required DiaryController diaryController});

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
        // Add more routes for other pages here
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

    // Delay for 1.5 seconds and then navigate to DiaryLogView
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      Navigator.pushReplacementNamed(context, '/diaryLogView');
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
