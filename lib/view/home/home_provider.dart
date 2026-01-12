import 'package:chat/data/domain/interfaces/i_user_repository.dart';
import 'package:chat/view/home/home_view.dart';
import 'package:chat/view_models/home_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) =>
          HomeViewModel(userRepository: context.read<IUserRepository>()),
      child: HomeView(),
    );
  }
}
