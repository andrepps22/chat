import 'package:auto_injector/auto_injector.dart';
import 'package:chat/data/domain/contract/repository.dart';
import 'package:chat/data/domain/contract/service.dart';
import 'package:chat/data/domain/contract/use_case.dart';
import 'package:chat/data/domain/contract/viewmodel.dart';

class CustomInjector {
  final _injector = AutoInjector();

  void addService<T extends Service>(Function constructor){
    _injector.addSingleton<T>(constructor);
  }

  void addRepository<T extends Repository>(Function constructor){
    _injector.addLazySingleton<T>(constructor);
  }

  void addUseCase<T extends UseCase>(Function constructor){
    _injector.addLazySingleton<T>(constructor);
  }

  void addViewmodel<T extends Viewmodel>(Function constructor){
    _injector.add<T>(constructor);
  }

  void commit(){
    _injector.commit();
  }

  void dispose(){
    _injector.dispose();
  }


  T getViewmodel<T extends Viewmodel>(){
    return _injector.get<T>();
  }

  T getRepository<T extends Repository>(){
    return _injector.get<T>();
  }

  T getUseCase<T extends UseCase>(){
    return _injector.get<T>();
  }
}