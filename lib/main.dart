import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/view/auth_view/auth_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDark = false;

  void alterarTema(){
    setState(() {
      isDark = !isDark;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark? AppTheme.dark: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: AuthView(funcao: alterarTema,));
  }
}
