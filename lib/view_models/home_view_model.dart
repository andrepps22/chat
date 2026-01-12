import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/use_cases/user_use_case.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/view_models/command.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier {
  late final Command getUsersCommand;
  late final Command logoutCommand;
  final UserUseCase _userRepository;
  final IAuthRepository _authRepository;
  List<UserModel>? usersList;

  String? errorMessage;

  HomeViewModel({
    required UserUseCase userRepository,
    required IAuthRepository authRepository,
  }) : _userRepository = userRepository,
       _authRepository = authRepository {
    getUsersCommand = Command(() => _userRepository.getUsers());
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
