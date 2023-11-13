// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:deardiary/view/diary_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controller/diary_entry_service.dart';
import 'diary_entry_view.dart';
import '../model/diary_entry_model.dart';
import 'diary_statistics_view.dart';

class DiaryLogView extends StatefulWidget {
  const DiaryLogView({Key? key}) : super(key: key);

  @override
  _DiaryLogViewState createState() => _DiaryLogViewState();
}

class _DiaryLogViewState extends State<DiaryLogView> {
  List<DiaryEntry> _diaryEntries = [];

  @override
  void initState() {
    super.initState();
    _loadDiaryEntries();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  Future<void> _loadDiaryEntries() async {
    try {
      // Use your DiaryEntryService to fetch the entries
      final diaryService = DiaryEntryService();
      final entries = await diaryService.getAllDiaryEntries();

      setState(() {
        _diaryEntries = entries;
      });
    } catch (e) {
      print('Error loading diary entries: $e');
    }
  }

  void onDiaryEntryTap(DiaryEntry entry, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryView(
          diaryEntry: entry, // Pass the selected entry for editing
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the current user
      Navigator.pushReplacementNamed(
          context, '/loginView'); // Navigate to the login screen
    } catch (e) {
      print('Error logging out: $e');
      // Handle the error as needed (e.g., display an error message)
    }
  }

  Future<void> _refresh() async {
    await _loadDiaryEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary Entries'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiaryStatisticView(),
                ),
              );
            },
            icon: Icon(Icons.analytics), // Choose an appropriate icon
          ),
          IconButton(
            onPressed: () {
              _handleLogout();
              // Navigate to the login or authentication screen
              Navigator.pushReplacementNamed(context, '/loginView');
            },
            icon: Icon(Icons.logout), // You can change the icon as needed
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: _refresh,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        strokeWidth: 1.0,
        child: ListView(
          children: <Widget>[
            for (final diaryEntry in _diaryEntries)
              GestureDetector(
                onTap: () => onDiaryEntryTap(diaryEntry, context),
                child: DiaryEntryCard(
                  date: diaryEntry.date,
                  content: diaryEntry.content,
                  rating: diaryEntry.rating,
                  parent: this,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiaryEntryView()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class DiaryEntryCard extends StatelessWidget {
  final String date;
  final String content;
  final int rating;
  final _DiaryLogViewState parent;

  const DiaryEntryCard({
    Key? key,
    required this.date,
    required this.content,
    required this.rating,
    required this.parent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Date: $date',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Content: $content'),
            const SizedBox(height: 8.0),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
