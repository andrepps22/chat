import 'package:chat/core/auth/e_auth_state.dart';
import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/data/domain/contract/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class IAuthRepository extends Repository {
  Stream<EAuthState> authState();
  Future<Result<User?, Exception>> login(UserDto userDto);
  Future<Result<UserCredential, Exception>> register(UserDto userDto);
  Future<void> logout();
  User? get currentUser;
  
}