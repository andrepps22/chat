import 'package:chat/data/domain/DTOs/send_messager_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final db = FirebaseFirestore.instance;

  Future<void> sendMessager(SendMessagerDto messager) async {
    await db
        .collection("chat_rooms")
        .doc(messager.chatRoomId)
        .collection("messages")
        .add(messager.messager.toJson());
  }

  Stream<QuerySnapshot> getMessages(String chatRoomID) {
        return db
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
