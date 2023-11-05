import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/diary_entry_model.dart';

class DiaryEntryService {
  final user = FirebaseAuth.instance.currentUser;
 
  final CollectionReference DiaryEntryCollection;

  DiaryEntryService()
      : DiaryEntryCollection = FirebaseFirestore.instance
            .collection('diary_entries')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('userDiaryEntries');

  Future<DocumentReference<Object?>> addNewDiaryEntry(
      DiaryEntry diaryEntry) async {
    return await DiaryEntryCollection.add(diaryEntry.toMap());
  }

  Future<List<DiaryEntry>> getAllDiaryEntries() async {
    QuerySnapshot snapshot = await DiaryEntryCollection.get();
    return snapshot.docs.map((doc) => DiaryEntry.fromMap(doc)).toList();
  }

  Future<void> updateDiaryEntry(DiaryEntry diaryEntry) async {
    return await DiaryEntryCollection.doc(diaryEntry.id)
        .update(diaryEntry.toMap());
  }

  Future<void> deleteDiaryEntry(DiaryEntry diaryEntry) async {
    return await DiaryEntryCollection.doc(diaryEntry.id).delete();
  }
}
