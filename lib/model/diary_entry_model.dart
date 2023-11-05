import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryEntry {
  String id; // Document ID in Firestore
  String date;
  String content;
  int rating;

  DiaryEntry({
    this.id = '', // Initialize with an empty string
    required this.date,
    required this.content,
    required this.rating,
  });

  // Convert a Firestore snapshot into a DiaryEntry instance
  static DiaryEntry fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DiaryEntry(
      id: doc.id,
      date: data['date'],
      content: data['content'],
      rating: data['rating'],
    );
  }

  // Convert the DiaryEntry instance to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'content': content,
      'rating': rating,
    };
  }
}
