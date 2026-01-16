import 'package:chat/core/utils/custom_injector.dart';
import 'package:chat/data/domain/contract/viewmodel.dart';
import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/interfaces/i_messager_repository.dart';
import 'package:chat/data/domain/interfaces/i_user_repository.dart';
import 'package:chat/data/domain/use_cases/chat_use_case.dart';
import 'package:chat/data/domain/use_cases/user_use_case.dart';
import 'package:chat/data/repository/auth_repository_impl.dart';
import 'package:chat/data/repository/messager_repository.dart';
import 'package:chat/data/repository/user_repository_impl.dart';
import 'package:chat/data/services/auth_services.dart';
import 'package:chat/data/services/firestone_firebase_service.dart';
import 'package:chat/data/services/message_service.dart';
import 'package:chat/view/auth_view/auth_view_model.dart';
import 'package:chat/view/chat/chat_view_model.dart';
import 'package:chat/view/home/home_view_model.dart';
import 'package:provider/provider.dart';

final _injector = CustomInjector();

void setupDependencies() {
  _injector.addService<AuthServices>(AuthServices.new);
  _injector.addService<FirestoneFirebaseService>(FirestoneFirebaseService.new);
  _injector.addService<MessageService>(MessageService.new);
  _injector.addRepository<IAuthRepository>(AuthRepositoryImpl.new);
  _injector.addRepository<IUserRepository>(UserRepositoryImpl.new);
  _injector.addRepository<IMessagerRepository>(MessagerRepository.new);
  _injector.addUseCase<UserUseCase>(UserUseCase.new);
  _injector.addUseCase<ChatUseCase>(ChatUseCase.new);

  _injector.addViewmodel<AuthViewModel>(AuthViewModel.new);
  _injector.addViewmodel<HomeViewModel>(HomeViewModel.new);
  _injector.addViewmodel<ChatViewModel>(ChatViewModel.new);

  _injector.commit();
}

void disposeDependencies() {
  _injector.dispose();
}

class ViewModelProvider<T extends Viewmodel> extends ChangeNotifierProvider<T> {
  ViewModelProvider({super.key, super.child})
    : super(create: (context) => _injector.getViewmodel<T>());
}
