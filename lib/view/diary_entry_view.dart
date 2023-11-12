import 'package:deardiary/model/diary_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../controller/diary_entry_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  File? _pickedImage;

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
      print(_selectedDate);
    }
  }

  Future<void> _uploadImage() async {
    try {
      if (_pickedImage != null) {
        final fileName =
            'diary_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final ref =
            firebase_storage.FirebaseStorage.instance.ref().child(fileName);

        await ref.putFile(_pickedImage!);

        // Get the download URL of the uploaded image
        final imageUrl = await ref.getDownloadURL();

        // Now, you can store the imageUrl in your database or use it as needed
        print('Image uploaded successfully. URL: $imageUrl');
      } else {
        print('No image picked.');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _pickeImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Widget _displayPickedImage() {
    return _pickedImage != null
        ? Image.file(
            _pickedImage!,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          )
        : Container(); // You can customize this container as needed
  }

  Future<void> _loadExistingDates() async {
    try {
      final diaryService = DiaryEntryService();
      final entries = await diaryService.getAllDiaryEntries();
      final dates = entries.map((e) => e.date).toList();
      setState(() {
        existingDates = dates;
      });
    } catch (e) {
      print('Error loading diary entries: $e');
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
          _uploadImage();
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
            ElevatedButton(
              onPressed: _pickeImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Customize the button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Upload Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Display the picked image
            _displayPickedImage(),
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
        // Navigate to the diary_log_view after deleting the entry
        Navigator.pop(context, true);
        Navigator.pushReplacementNamed(context, '/diaryLogView');
      } catch (e) {
        print('Error deleting diary entry: $e');
      }
    }
  }

  void _saveDiaryEntry() async {
    final selectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final content = _descriptionController.text;
    print(existingDates);
    if (existingDates.contains(selectedDate)) {
      // Date already exists, show a warning dialog.
      _showWarningDialog();
      return; // Don't save the entry if the date already exists
    }

    final newEntry = DiaryEntry(
      date: selectedDate,
      content: content,
      rating: _rating,
    );

    final diaryService = DiaryEntryService();
    try {
      await diaryService.addNewDiaryEntry(newEntry);
      // Show a confirmation SnackBar
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

      // Navigate to the diary_log_view
      Navigator.pop(context, true);
      Navigator.pushReplacementNamed(context, '/diaryLogView');
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

        Navigator.pop(context, true);
        Navigator.pushReplacementNamed(context, '/diaryLogView');
      } catch (e) {
        print('Error updating diary entry: $e');
      }
    }
  }
}
