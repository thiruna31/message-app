import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===================== USERS ===========================

  Future<void> addUser(
      String uid, String first, String last, String role) async {
    await _db.collection('users').doc(uid).set({
      'firstname': first,
      'lastname': last,
      'role': role,
      'registeredAt': FieldValue.serverTimestamp(),
    });
  }

  // ===================== SEND MESSAGE =====================

  Future<void> sendMessage(String boardId, MessageModel msg) async {
    await _db
        .collection('boards')
        .doc(boardId)
        .collection('messages')
        .add(msg.toMap());
  }

  // ===================== FETCH MESSAGES (REAL-TIME) ========

  Stream<List<MessageModel>> fetchMessages(String boardId) {
    return _db
        .collection('boards')
        .doc(boardId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return MessageModel.fromMap(data, doc.id);
        }).toList();
      },
    );
  }
}
