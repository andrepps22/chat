import 'package:chat/data/domain/DTOs/send_messager_dto.dart';
import 'package:chat/data/domain/contract/use_case.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/interfaces/i_messager_repository.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatUseCase extends UseCase{
  final IAuthRepository _authRepository;
  final IMessagerRepository _messagerRepository;

  ChatUseCase({required IAuthRepository authRepository, required IMessagerRepository messagerRepository})
    : _authRepository = authRepository, _messagerRepository =messagerRepository;
    
  User? get currentUser => _authRepository.currentUser;
  
  Future<void> sendMessager(MessagerModel messager)async {
    List<String> ids = [messager.senderUserId, messager.receiverUserId];
    ids.sort();

    String chatRoomId = ids.join("-");
    final SendMessagerDto sendMessager = SendMessagerDto(chatRoomId: chatRoomId, messager: messager);

    await _messagerRepository.sendMessager(sendMessager);

  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();

    String chatRoomId = ids.join("-");

    return _messagerRepository.getMessages(chatRoomId);

  }

  
}