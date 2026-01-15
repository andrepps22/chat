import 'package:chat/data/models/message_model.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/view_models/chat_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final UserModel user =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    final vm = context.watch<ChatViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text(user.nome), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Container(child: Center(child: Text('data'))),
            ),
            Form(
              key: formKey,
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      vm.messager = MessagerModel(
                        senderUserId: vm.currentUser!.uid,
                        senderEmail: vm.currentUser!.email!,
                        message: message.text,
                        receiverUserId: user.uuid,
                        timestamp: Timestamp.now(),
                      );
                      message.clear();
                      await vm.sendMassage();

                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
