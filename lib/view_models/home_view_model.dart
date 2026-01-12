import 'package:chat/core/utils/result.dart';
import 'package:chat/data/domain/interfaces/i_user_repository.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/view_models/command.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier {
  late final Command getUsersCommand;
  final IUserRepository _userRepository;
  List<UserModel>? usersList;
  
  String? errorMessage;

  HomeViewModel({required IUserRepository userRepository})
    : _userRepository = userRepository {
    getUsersCommand = Command(() => _userRepository.getUsers());

    getUsersCommand.addListener(notifyListeners);
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

  @override
  void dispose() {
    getUsersCommand.removeListener(notifyListeners);
    super.dispose();
  }
}
