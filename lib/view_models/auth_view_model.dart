import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/view_models/command.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  late final Command authLoginCommand;
  late final Command authRegisterCommand;
  final IAuthRepository _authRepository;
  UserDto? userDto;
  bool islogged = false;
  String? errorMessage;
  bool isLogin = true;

  AuthViewModel({required IAuthRepository authRepository}):_authRepository = authRepository {
    authLoginCommand = Command(() => _authRepository.login(userDto!),);
    authRegisterCommand = Command(() => _authRepository.register(userDto!),);

    authLoginCommand.addListener(notifyListeners);
    authRegisterCommand.addListener(notifyListeners);
  }
  void toogleLoginRegister(){
    isLogin = !isLogin;
    notifyListeners();
  }

  @override
  void dispose() {
    errorMessage = null;
    authLoginCommand.removeListener(notifyListeners);
    authRegisterCommand.removeListener(notifyListeners);
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
  Future<void> register() async {
    await authRegisterCommand.execute();

    final Result<UserCredential, Exception> result = authRegisterCommand.data;

    result.when(
      success: (value) {
        islogged = true;
      }, 
      failure: (exception){  
        islogged = false;
        errorMessage = exception.toString();});

  }

}