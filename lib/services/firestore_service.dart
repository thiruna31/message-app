import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class FirestoreService {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  Future<void> addUser(String uid, String first, String last, String role) async {
    await users.doc(uid).set({
      'firstname': first,
      'lastname': last,
      'role': role,
      'registeredAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendMessage(String boardId, MessageModel msg) async {
    await messages.add({
      ...msg.toMap(),
      'boardId': boardId,
      'timestamp': Timestamp.fromDate(msg.timestamp),
    });
  }

  Stream<List<MessageModel>> fetchMessages(String boardId) {
    return messages
        .where('boardId', isEqualTo: boardId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) {
              final data = d.data() as Map<String, dynamic>;
              return MessageModel.fromMap(data);
            }).toList());
  }
}
