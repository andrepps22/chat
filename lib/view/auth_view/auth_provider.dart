import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/use_cases/register_user_use_case.dart';
import 'package:chat/view/auth_view/auth_gate.dart';
import 'package:chat/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(
        authRepository: context.read<IAuthRepository>(),
        registerUserUseCase: context.read<RegisterUserUseCase>(),
      ),
      child: AuthGate(),);
  }
}