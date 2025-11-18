import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/message_model.dart';
import '../widgets/message_tile.dart';

class ChatScreen extends StatefulWidget {
  final String boardId;
  final String boardName;

  const ChatScreen({super.key, required this.boardId, required this.boardName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final firestore = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.boardName), backgroundColor: Colors.deepPurple),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: firestore.fetchMessages(widget.boardId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
                }
                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final m = messages[index];
                    final isMe = m.senderId == auth.currentUser?.uid;
                    return MessageTile(text: '${m.displayName}\n${m.text}', isMe: isMe);
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(color: const Color(0xfff3eaff), borderRadius: BorderRadius.circular(20)),
                    child: TextField(controller: msgCtrl, decoration: const InputDecoration(hintText: 'Type a message...', border: InputBorder.none)),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    final text = msgCtrl.text.trim();
                    if (text.isEmpty) return;
                    final uid = auth.currentUser?.uid;
                    final name = auth.currentUser?.email?.split('@').first ?? 'User';
                    if (uid == null) return;
                    final msg = MessageModel(senderId: uid, displayName: name, text: text, timestamp: DateTime.now());
                    await firestore.sendMessage(widget.boardId, msg);
                    msgCtrl.clear();
                  },
                  child: const CircleAvatar(backgroundColor: Colors.deepPurple, child: Icon(Icons.send, color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
