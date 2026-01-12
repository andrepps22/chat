import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_register_dto.dart';
import 'package:chat/data/domain/interfaces/i_user_repository.dart';
import 'package:chat/data/models/user_model.dart';
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
  Future<Result<List<UserModel>, Exception>> getUsers() async {
    final result = await firestoneService.getUsers();
    return result.when(
      success: (value){
        final List<UserModel> users = value.docs.map(
          
          (e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return UserModel.fromJson(data);
          }
        ).toList();
        return Success(users);
      }, 
      failure:(exception) => Failure(exception),);
  }
}