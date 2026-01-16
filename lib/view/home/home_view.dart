import 'package:chat/core/router/app_router_static.dart';
import 'package:chat/view/home/home_view_model.dart';
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
      appBar: AppBar(title: Text('Home'), centerTitle: true, actions: [
        IconButton(onPressed: ()async{
          vm.logout();
          Navigator.of(context).pushNamedAndRemoveUntil(AppRouterStatic.login, (route) => false,)
          ;}, icon: Icon(Icons.logout))
      ],),
      body: vm.getUsersCommand.isExecuting?
      CircularProgressIndicator():vm.usersList == null? Center(child: Text('Não tem usuarios cadastrados.'),):
      Center(child: ListView.builder(
        itemCount: vm.usersList!.length ,
        itemBuilder: (context, index) {
          final user = vm.usersList![index];
          return InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(AppRouterStatic.chat, arguments: user);
            },
            
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(user.nome),
              subtitle: Text(user.email),
            ),
          );
        },)
      ),
    );
  }
}