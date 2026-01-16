import 'package:chat/core/auth/e_auth_state.dart';
import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/data/domain/contract/viewmodel.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/use_cases/user_use_case.dart';
import 'package:chat/view_models/command.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel extends Viewmodel {
  late final Command authLoginCommand;
  late final Command authRegisterCommand;
  final IAuthRepository _authRepository;
  final UserUseCase _registerUserUseCase;
  UserDto? userDto;
  String? nome; // Add nome field
  bool islogged = false;
  String? errorMessage;
  bool isLogin = true;

  AuthViewModel({
    required IAuthRepository authRepository,
    required UserUseCase registerUserUseCase,
  }) : _authRepository = authRepository,
       _registerUserUseCase = registerUserUseCase {
    authLoginCommand = Command(() => _authRepository.login(userDto!),);
    authRegisterCommand = Command(() => _registerUserUseCase.execute(userDto!),); // Use use case

    authLoginCommand.addListener(notifyListeners);
    authRegisterCommand.addListener(notifyListeners);
  }
  void toogleLoginRegister(){
    isLogin = !isLogin;
    notifyListeners();
  }

  Stream<EAuthState> get authState => _authRepository.authState();

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

    final Result<String, Exception> result = authRegisterCommand.data;

    result.when(
      success: (value) {
        islogged = true;
      }, 
      failure: (exception){  
        islogged = false;
        errorMessage = exception.toString();});

  }

}