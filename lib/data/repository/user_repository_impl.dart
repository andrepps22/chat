import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_register_dto.dart';
import 'package:chat/data/domain/interfaces/i_user_repository.dart';
import 'package:chat/data/services/firestone_firebase_service.dart';

class UserRepositoryImpl implements IUserRepository {
  final FirestoneFirebaseService firestoneService;

  UserRepositoryImpl({required this.firestoneService});

  @override
  Future<Result<String, Exception>> saveUser(UserRegisterDto userDto) async {
    final userJson = userDto.toJson();
    return await firestoneService.addUser(userJson);
  }
  
  @override
  Future<Result<List, Exception>> getUsers() async {
    final result = await firestoneService.getUsers();
    return result.when(
      success: (value) => Success(value), 
      failure:(exception) => Failure(exception),);
  }
}