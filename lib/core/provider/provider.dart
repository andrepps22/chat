import 'package:chat/core/config/dependencies.dart';
import 'package:chat/view/auth_view/auth_view_model.dart';
import 'package:chat/view/chat/chat_view_model.dart';
import 'package:chat/view/home/home_view_model.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  List<SingleChildStatelessWidget> get provider {
    return [
      ViewModelProvider<AuthViewModel>(),
      ViewModelProvider<HomeViewModel>(),
      ViewModelProvider<ChatViewModel>(),
    ];
  }
}
