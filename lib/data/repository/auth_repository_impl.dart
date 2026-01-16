import 'package:chat/core/auth/e_auth_state.dart';
import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthServices authServices;

  AuthRepositoryImpl(this.authServices);

  @override
  Stream<EAuthState> authState() {
    return authServices.authState().map(
      (user) => user == null? EAuthState.unauthenticated: EAuthState.authenticated,
    );
  }

  @override
  Future<Result<User?, Exception>> login(UserDto userDto) async {
    final userJson = userDto.toJson();
    final result = await authServices.signIn(userJson: userJson);

    return result.when(success: (value) => Success(value), failure: (exception) => Failure(exception),);
  }

  @override
  Future<void> logout() async {
    await authServices.signOut();
  }

  @override
  Future<Result<UserCredential, Exception>> register(UserDto userDto) async {
    final userJson = userDto.toJson();
    final result = await authServices.signUp(userJson: userJson);

    return result.when(
      success: (value) => Success(value), 
      failure: (exception) => Failure(exception),);
  }

  @override
  User? get currentUser => authServices.currentUser;
  
  
}