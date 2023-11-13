// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import '../model/diary_entry_model.dart';
import '../controller/diary_entry_service.dart';
import 'diary_entry_view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DiaryView extends StatelessWidget {
  final DiaryEntry diaryEntry;

  DiaryView({required this.diaryEntry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary Entry View'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _handleEdit(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Centered image
            if (diaryEntry.imageUrl!.isNotEmpty)
              Center(
                child: Image.network(
                  diaryEntry.imageUrl!,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'Date: ${diaryEntry.date}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Display the rating using stars
            Row(children: [
              const Text(
                'Rating:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...List.generate(5, (index) {
                return Icon(
                  index < diaryEntry.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ]),
            const SizedBox(height: 8),
            const Text(
              'Content:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              diaryEntry.content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _handleEdit(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryEntryView(diaryEntry: diaryEntry),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Entry'),
          content: const Text('Are you sure you want to delete this entry?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteDiaryEntry(context);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteDiaryEntry(BuildContext context) async {
    final diaryService = DiaryEntryService();
    try {
      // Check if the entry has an associated image URL
      if (diaryEntry.imageUrl != null && diaryEntry.imageUrl!.isNotEmpty) {
        // Reference to the image in Firebase Storage
        final storageReference = firebase_storage.FirebaseStorage.instance
            .refFromURL(diaryEntry.imageUrl!);

        // Delete the image from storage
        await storageReference.delete();
      }
      // Delete the diary entry
      await diaryService.deleteDiaryEntry(diaryEntry);

      // Optionally, you can show a confirmation message.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Diary entry deleted successfully'),
        ),
      );

      // Navigate back to the diary log view
      Navigator.pop(context, true);
      Navigator.pushReplacementNamed(context, '/diaryLogView');
    } catch (e) {
      print('$e');
    }
  }
}
