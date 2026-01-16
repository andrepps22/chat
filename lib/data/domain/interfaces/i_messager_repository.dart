import 'package:chat/data/domain/DTOs/send_messager_dto.dart';
import 'package:chat/data/domain/contract/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class IMessagerRepository extends Repository {
  Future<void> sendMessager(SendMessagerDto messager);
  Stream<QuerySnapshot> getMessages(String chatRoomID);
  
}
