import 'package:chat/core/router/app_router_static.dart';
import 'package:chat/view/auth_view/auth_gate.dart';
import 'package:chat/view/chat/chat_view.dart';
import 'package:chat/view/home/home_view.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  Map<String, WidgetBuilder> router = {
    AppRouterStatic.login: (ctx) => AuthGate(),
    AppRouterStatic.home: (ctx) => HomeView(),
    AppRouterStatic.chat: (ctx) => ChatView()
    
  };
}