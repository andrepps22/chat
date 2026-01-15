import 'package:chat/data/domain/use_cases/chat_use_case.dart';
import 'package:chat/view/chat/chat_view.dart';
import 'package:chat/view_models/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatProvider extends StatelessWidget {
  const ChatProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatViewModel>(
      create: (context) =>
          ChatViewModel(chatUserCase: context.read<ChatUseCase>()),
      child: ChatView(),
    );
  }
}
