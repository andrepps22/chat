import 'package:chat/data/domain/interfaces/i_auth_repository.dart';
import 'package:chat/data/repository/auth_repository_impl.dart';
import 'package:chat/data/services/auth_firebase_services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  List<SingleChildStatelessWidget> get provider {
    return [
      //=============Services======================
      Provider<AuthServices>(create: (context) => AuthServices(),),

      //=============Repository====================
      ProxyProvider<AuthServices, IAuthRepository>(
        update: (_, authServices, _) => AuthRepositoryImpl(authServices: authServices),)
      ];
  }
}
