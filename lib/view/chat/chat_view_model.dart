import 'package:chat/data/domain/contract/viewmodel.dart';
import 'package:chat/data/domain/use_cases/chat_use_case.dart';
import 'package:chat/data/models/message_model.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/view_models/command.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatViewModel extends Viewmodel {
  final ChatUseCase _chatUserCase;
  late final Command sendMessageCommand;
  MessagerModel? messager;
  UserModel? otherUser;


  ChatViewModel({required ChatUseCase chatUserCase}): _chatUserCase = chatUserCase {
    sendMessageCommand = Command(() => _chatUserCase.sendMessager(messager!),);

    sendMessageCommand.addListener(notifyListeners);
  }

  Stream<QuerySnapshot> get listMessages => _chatUserCase.getMessages(currentUser!.uid, otherUser!.uuid);

  @override
  void dispose() {
    sendMessageCommand.removeListener(notifyListeners);
    super.dispose();
  }

  User? get currentUser => _chatUserCase.currentUser;

  Future<void> sendMassage(
    
    
  ) async {
    await sendMessageCommand.execute();
  }
  
}