import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/services/auth_firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthServices authServices;

  AuthRepositoryImpl({
    required this.authServices
  });


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
  Future<Result<User?, Exception>> register(UserDto userDto) async {
    final userJson = userDto.toJson();
    final result = await authServices.signUp(userJson: userJson);

    return result.when(success: (value) => Success(value), failure: (exception) => Failure(exception),);
  }
  User? get currentUser => authServices.currentUser;
}