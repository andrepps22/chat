import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/domain/interfaces/i_user_repository.dart';
import 'package:chat/data/domain/use_cases/user_use_case.dart';
import 'package:chat/data/repository/auth_repository_impl.dart';
import 'package:chat/data/repository/user_repository_impl.dart';
import 'package:chat/data/services/auth_firebase_services.dart';
import 'package:chat/data/services/firestone_firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  List<SingleChildStatelessWidget> get provider {
    return [
      //=============Services======================
      Provider<AuthServices>(create: (context) => AuthServices(),),
      Provider<FirestoneFirebaseService>(create: (context) => FirestoneFirebaseService(),),

      //=============Repository====================
      ProxyProvider<AuthServices, IAuthRepository>(
        update: (_, authServices, _) => AuthRepositoryImpl(authServices: authServices),),
      ProxyProvider<FirestoneFirebaseService, IUserRepository>(
        update: (_, firestoneService, _) => UserRepositoryImpl(firestoneService: firestoneService),),

      //=============Use Cases====================
      ProxyProvider2<IAuthRepository, IUserRepository, UserUseCase>(
        update: (_, authRepo, userRepo, _) => UserUseCase(
          authRepository: authRepo,
          userRepository: userRepo,
        ),),
      ];
  }
}
