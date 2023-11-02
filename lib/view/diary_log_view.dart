import 'package:flutter/material.dart';
import 'diary_entry_view.dart';
import '../model/diary_entry_model.dart';
import '../controller/diary_controller.dart';

class DiaryLogView extends StatefulWidget {
  const DiaryLogView({Key? key}) : super(key: key);

  @override
  _DiaryLogViewState createState() => _DiaryLogViewState();
}

class _DiaryLogViewState extends State<DiaryLogView> {
  final DiaryController _diaryController = DiaryController();
  List<DiaryEntry> _diaryEntries = [];

  @override
  void initState() {
    super.initState();
    _loadDiaryEntries();
  }

  Future<void> _loadDiaryEntries() async {
    await _diaryController.init();
    final entries = _diaryController.getDiaryEntries();
    if (mounted) {
      setState(() {
        _diaryEntries = entries;
      });
    }
  }

  // void onDiaryEntryTapped(DiaryEntry entry, BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => DiaryEntryView(
  //         diaryEntry: entry, // Pass the selected entry for editing
  //       ),
  //     ),
  //   );
  // }

  void onDiaryEntryLongPressed(DiaryEntry entry, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryEntryView(
          diaryEntry: entry, // Pass the selected entry for editing
        ),
      ),
    );
  }

  @override
  void dispose() {
    _diaryController.closeBox();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadDiaryEntries();
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
      ),
      body: ListView(
        children: <Widget>[
          for (final diaryEntry in _diaryEntries)
            GestureDetector(
              onLongPress: () {
                // onDiaryEntryTapped(diaryEntry, context);
                onDiaryEntryLongPressed(diaryEntry, context);
              },
              child: DiaryEntryCard(
                date: diaryEntry.date,
                content: diaryEntry.content,
                rating: diaryEntry.rating,
                parent: this,
              ),
            ),
        ],
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
