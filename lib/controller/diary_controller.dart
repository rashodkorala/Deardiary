import 'package:hive_flutter/hive_flutter.dart';
import '../model/diary_entry_model.dart';

class DiaryController {
  static late Box<DiaryEntry> _diaryBox;

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DiaryEntryAdapter());
    }
    _diaryBox = await Hive.openBox<DiaryEntry>('diary_entries');
  }

  // Create a new diary entry
  Future<void> addDiaryEntry(DiaryEntry entry) async {
    await _diaryBox.add(entry);
  }

  // Retrieve all diary entries
  List<DiaryEntry> getDiaryEntries() {
    return _diaryBox.values.toList();
  }

  // Update a diary entry
  Future<void> updateDiaryEntry(int index, DiaryEntry updatedEntry) async {
    await _diaryBox.putAt(index, updatedEntry);
  }

  // Delete a diary entry
  Future<void> deleteDiaryEntry(int index) async {
    await _diaryBox.deleteAt(index);
  }

  //Close the Hive box when no longer needed
  Future<void> closeBox() async {
    await _diaryBox.close();
    print('Box is now closed');
  }
}
