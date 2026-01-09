import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/view_models/command.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  late final Command authLoginCommand;
  final IAuthRepository _authRepository;
  UserDto? userDto;
  bool islogged = false;
  String? errorMessage;

  AuthViewModel({required IAuthRepository authRepository}):_authRepository = authRepository {
    authLoginCommand = Command(() => _authRepository.login(userDto!),);

    authLoginCommand.addListener(notifyListeners);
  }

  @override
  void dispose() {
    errorMessage = null;
    authLoginCommand.removeListener(notifyListeners);
    super.dispose();
  }


  Future<void> login() async {
    await authLoginCommand.execute();

    final Result<User?, Exception> result = authLoginCommand.data;

    result.when(
      success: (value) {
        islogged = true;
      }, 
      failure: (exception){  
        islogged = false;
        errorMessage = exception.toString();});

  }

}