import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/interfaces/i_messager_repository.dart';
import 'package:chat/data/domain/interfaces/i_user_repository.dart';
import 'package:chat/data/domain/use_cases/chat_use_case.dart';
import 'package:chat/data/domain/use_cases/user_use_case.dart';
import 'package:chat/data/repository/auth_repository_impl.dart';
import 'package:chat/data/repository/messager_repository.dart';
import 'package:chat/data/repository/user_repository_impl.dart';
import 'package:chat/data/services/auth_firebase_services.dart';
import 'package:chat/data/services/firestone_firebase_service.dart';
import 'package:chat/data/services/message_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  List<SingleChildStatelessWidget> get provider {
    return [
      //=============Services======================
      Provider<AuthServices>(create: (context) => AuthServices()),
      Provider<FirestoneFirebaseService>(
        create: (context) => FirestoneFirebaseService(),
      ),
      Provider<MessageService>(
        create: (context) => MessageService(),
      ),

      //=============Repository====================
      ProxyProvider<AuthServices, IAuthRepository>(
        update: (_, authServices, _) =>
            AuthRepositoryImpl(authServices: authServices),
      ),
      ProxyProvider<FirestoneFirebaseService, IUserRepository>(
        update: (_, firestoneService, _) =>
            UserRepositoryImpl(firestoneService: firestoneService),
      ),
      ProxyProvider<MessageService, IMessagerRepository>(
        update: (_, messageService, _) =>
            MessagerRepository(messageService: messageService),
      ),

      //=============Use Cases====================
      ProxyProvider2<IAuthRepository, IUserRepository, UserUseCase>(
        update: (_, authRepo, userRepo, _) =>
            UserUseCase(authRepository: authRepo, userRepository: userRepo),
      ),

      ProxyProvider2<IAuthRepository, IMessagerRepository, ChatUseCase>(
        update: (_, authRepo, messsageRepo, _) => ChatUseCase(
          authRepository: authRepo,
          messagerRepository: messsageRepo,
        ),
      ),
    ];
  }
}
