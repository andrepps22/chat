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
  User? currentUser;

  @override
  Future<Result<User?, Exception>> login(UserDto userDto) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<User?, Exception>> register(UserDto userDto) {
    // TODO: implement register
    throw UnimplementedError();
  }
}