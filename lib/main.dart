import 'package:chat/core/provider/provider.dart';
import 'package:chat/core/router/app_router.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  runApp(MultiProvider(providers: Providers().provider, child: MainApp(),));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDark = false;

  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRouter().router,
      theme: isDark? AppTheme.dark: AppTheme.light,
      debugShowCheckedModeBanner: false,
      );
  }
}
