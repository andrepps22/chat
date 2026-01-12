import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/data/domain/DTOs/user_register_dto.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/interfaces/i_user_repository.dart';
import 'package:chat/data/models/user_model.dart';

class UserUseCase {
  final IAuthRepository authRepository;
  final IUserRepository userRepository;

  UserUseCase({
    required this.authRepository,
    required this.userRepository,
  });

  Future<Result<String, Exception>> execute(UserDto userDto) async {
    // First, register the user with Firebase Auth
    final authResult = await authRepository.register(userDto);

    return await authResult.when(
      success: (value) async {
        final userCredential = value.user;

        if (userCredential == null) {
          return Failure(Exception('UserCredential é nulo'));
        }

        final userRegisterDto = UserRegisterDto(
          uuid: userCredential.uid,
          nome: userDto.nome,
          email: userDto.email,
        );

        // 2. Salvar no banco
        final saveResult = await userRepository.saveUser(userRegisterDto);

        // 3. Retornar o resultado final
        return saveResult.when(
          success: (value) => Success(value),
          failure: (exception) => Failure(exception),
        );
      },
      failure: (exception) => Failure(exception),
    );
  }

  Future<Result<List<UserModel>, Exception>> getUsers()async{
    final userCurrent = authRepository.currentUser;
    final userList = await userRepository.getUsers();

    return userList.when(
      success: (value) {
        final listaUserModel = value.where((element) => element.uuid != userCurrent!.uid,).toList();

        return Success(listaUserModel);
      }, 
      failure: (exception) => Failure(exception),);
  }
}
