import 'package:chat/data/models/message_model.dart';

class SendMessagerDto {
  final String chatRoomId;
  final MessagerModel messager;

  SendMessagerDto({required this.chatRoomId, required this.messager});
}