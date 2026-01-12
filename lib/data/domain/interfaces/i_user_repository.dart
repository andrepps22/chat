import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_register_dto.dart';
import 'package:chat/data/models/user_model.dart';

abstract interface class IUserRepository {
  Future<Result<String, Exception>> saveUser(UserRegisterDto userDto);
  Future<Result<List<UserModel>, Exception>> getUsers();

}