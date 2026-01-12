import 'package:chat/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().getUsers();
    },);
    super.initState();

   
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text('Home'), centerTitle: true,),
      body: vm.getUsersCommand.isExecuting?
      CircularProgressIndicator():vm.usersList == null? Center(child: Text('Não tem usuarios cadastrados.'),):
      Center(child: ListView.builder(
        itemCount: vm.usersList!.length ,
        itemBuilder: (context, index) {
          final user = vm.usersList![index];
          return ListTile(
            title: Text(user.nome),
          );
        },)
      ),
    );
  }
}