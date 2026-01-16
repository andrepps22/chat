import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/contract/viewmodel.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/use_cases/user_use_case.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/view_models/command.dart';

class HomeViewModel extends Viewmodel{
  late final Command getUsersCommand;
  late final Command logoutCommand;
  final UserUseCase _userUseCase;
  final IAuthRepository _authRepository;
  List<UserModel>? usersList;

  String? errorMessage;

  HomeViewModel({
    required UserUseCase userUserCase,
    required IAuthRepository authRepository,
  }) : _userUseCase = userUserCase,
       _authRepository = authRepository {
    getUsersCommand = Command(() => _userUseCase.getUsers());
    logoutCommand = Command(() => _authRepository.logout());

    getUsersCommand.addListener(notifyListeners);
    logoutCommand.addListener(notifyListeners);
  }

  Future<void> getUsers() async {
    await getUsersCommand.execute();

    final Result<List<UserModel>, Exception> result = getUsersCommand.data;

    result.when(
      success: (value) => usersList = value,
      failure: (exception) => errorMessage = exception.toString(),
    );

    notifyListeners();
  }

  void logout() {
    logoutCommand.execute();
  }

  @override
  void dispose() {
    getUsersCommand.removeListener(notifyListeners);
    logoutCommand.removeListener(notifyListeners);
    super.dispose();
  }
}
