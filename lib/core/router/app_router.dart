import 'package:chat/core/router/app_router_static.dart';
import 'package:chat/view/auth_view/auth_provider.dart';
import 'package:chat/view/chat/chat_view.dart';
import 'package:chat/view/home/home_provider.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  Map<String, WidgetBuilder> router = {
    AppRouterStatic.login: (ctx) => AuthProvider(),
    AppRouterStatic.home: (ctx) => HomeProvider(),
    AppRouterStatic.chat: (ctx) => ChatView()
    
  };
}