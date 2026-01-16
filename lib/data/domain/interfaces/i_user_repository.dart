import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_register_dto.dart';
import 'package:chat/data/domain/contract/repository.dart';
import 'package:chat/data/models/user_model.dart';

abstract interface class IUserRepository extends Repository{
  Future<Result<String, Exception>> saveUser(UserRegisterDto userDto);
  Future<Result<List<UserModel>, Exception>> getUsers();

}