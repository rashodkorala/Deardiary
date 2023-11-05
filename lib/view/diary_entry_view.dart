import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deardiary/model/diary_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/diary_entry_service.dart';

class DiaryEntryView extends StatefulWidget {
  final DiaryEntry? diaryEntry; // Add this line

  DiaryEntryView({this.diaryEntry});
  @override
  _DiaryEntryViewState createState() => _DiaryEntryViewState();
}

class _DiaryEntryViewState extends State<DiaryEntryView> {
  int _rating = 0;
  TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  List<String> existingDates = [];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadExistingDates();

    // Check if a diary entry is provided and load its data into the form
    if (widget.diaryEntry != null) {
      final diaryEntry = widget.diaryEntry!;
      isEditing = true;
      _rating = diaryEntry.rating;
      _descriptionController.text = diaryEntry.content;
      _selectedDate = DateTime.parse(diaryEntry.date);
    }
  }

  Future<void> _loadExistingDates() async {
    if (widget.diaryEntry != null) {
      final existingDate = widget.diaryEntry!.date;
      if (existingDates.contains(existingDate)) {
        // Date already exists, show a warning dialog.
        _showWarningDialog();
      }
    }
  }

  ElevatedButton buildDeleteButton() {
    if (isEditing) {
      return ElevatedButton(
        onPressed: () {
          _showDeleteConfirmationDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Customize the button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          'Delete Entry',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey, // Customize the button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          'Delete Entry',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  Future<void> _showWarningDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('An entry already exists for this date.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Entry'),
          content: Text('Are you sure you want to delete this entry?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteDiaryEntry();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  ElevatedButton buildSaveButton() {
    if (isEditing) {
      return ElevatedButton(
        onPressed: () {
          _updateDiaryEntry();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          'Update Entry',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          _saveDiaryEntry();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(
          'Save Entry',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  Widget _showButtons() {
    // final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    // final dateExists = existingDates.contains(formattedDate);
    // final isSameDate = widget.diaryEntry?.date == formattedDate;
    return Row(children: [
      buildSaveButton(),
      SizedBox(width: 120),
      buildDeleteButton(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Diary Entry' : 'Add Diary Entry'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
            Navigator.pushReplacementNamed(context, '/diaryLogView');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rate Your Day:'),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = index +
                          1; // Set the rating based on the selected star.
                    });
                  },
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text('Select Date:'),
            Text(
              '${_selectedDate.toLocal()}'.split(' ')[0],
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 20),
            const Text('Diary Entry (140 characters or less):'),
            TextField(
              controller: _descriptionController,
              maxLength: 140, // Limit the input to 140 characters
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Write your diary entry here',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // "Save" button to save the diary entry
            _showButtons(),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd')
          .format(picked); // Use picked instead of _selectedDate
      if (existingDates.contains(formattedDate) &&
          formattedDate != widget.diaryEntry?.date) {
        // Date already exists, you can show a message or disable the "Save Entry" button
        // For example, you can show a SnackBar.
        _showWarningDialog();
      } else {
        setState(() {
          _selectedDate = picked;
        });
      }
    }
  }

  void _deleteDiaryEntry() async {
    if (widget.diaryEntry != null) {
      final diaryService = DiaryEntryService();
      try {
        await diaryService.deleteDiaryEntry(widget.diaryEntry!);
        // Optionally, you can show a confirmation message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Diary entry deleted successfully'),
          ),
        );
      } catch (e) {
        print('Error deleting diary entry: $e');
      }
    }
  }

  void _saveDiaryEntry() async {
    final selectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final content = _descriptionController.text;

    final newEntry = DiaryEntry(
      date: selectedDate,
      content: content,
      rating: _rating,
    );

    final diaryService = DiaryEntryService();
    try {
      await diaryService.addNewDiaryEntry(newEntry);
      // Optionally, you can show a confirmation message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Diary entry saved successfully'),
        ),
      );
      // Clear the input fields after saving
      _descriptionController.text = '';
      setState(() {
        _rating = 0;
        _selectedDate = DateTime.now();
      });
    } catch (e) {
      print('Error saving diary entry: $e');
    }
  }

  void _updateDiaryEntry() async {
    if (widget.diaryEntry != null) {
      final selectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
      final content = _descriptionController.text;

      final updatedEntry = DiaryEntry(
        id: widget.diaryEntry!.id,
        date: selectedDate,
        content: content,
        rating: _rating,
      );

      final diaryService = DiaryEntryService();
      try {
        await diaryService.updateDiaryEntry(updatedEntry);
        // Optionally, you can show a confirmation message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Diary entry updated successfully'),
          ),
        );
      } catch (e) {
        print('Error updating diary entry: $e');
      }
    }
  }
}
