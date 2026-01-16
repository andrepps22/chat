import 'package:chat/data/domain/DTOs/send_messager_dto.dart';
import 'package:chat/data/domain/interfaces/i_messager_repository.dart';
import 'package:chat/data/services/message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagerRepository implements IMessagerRepository {
  final MessageService messageService;

  MessagerRepository({required this.messageService});

  @override
  Future<void> sendMessager(SendMessagerDto messager) async {
    await messageService.sendMessager(messager);
  }

  @override
  Stream<QuerySnapshot<Object?>> getMessages(String chatRoomID) {
    return messageService.getMessages(chatRoomID);
  }

  
}