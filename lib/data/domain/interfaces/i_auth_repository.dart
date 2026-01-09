import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class IAuthRepository {
  Future<Result<User?, Exception>> login(UserDto userDto);
  Future<Result<User?, Exception>> register(UserDto userDto);
  Future<void> logout();
  User? currentUser;
  
}