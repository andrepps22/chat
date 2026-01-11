import 'package:chat/core/router/app_router_static.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/view/components/custom_buttom.dart';
import 'package:chat/view/components/custom_textfield.dart';
import 'package:chat/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  final TextEditingController nome = TextEditingController();

  void onSaved(String? string) {}

  void login(AuthViewModel vm) async {
    vm.userDto = UserDto(nome: nome.text, email: email.text, password: senha.text);
    vm.isLogin ? await vm.login() : await vm.register();

    if (!mounted) return;

    if (vm.islogged) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRouterStatic.home, (route) => false);
    }
    if (vm.errorMessage != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(vm.errorMessage.toString()),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                vm.errorMessage = null;
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 20,),
                vm.isLogin
                    ? Text(
                        'Bem vindo, faça o login para continua',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : Text(
                        'Cria sua nova conta para continua',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                SizedBox(height: 30),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [
                      if (!vm.isLogin)
                      CustomTextfield(
                        label: 'Nome',
                        controller: nome,
                        onSaved: onSaved,
                      ),
                      CustomTextfield(
                        label: 'Email',
                        controller: email,
                        onSaved: onSaved,
                      ),
                      CustomTextfield(
                        label: 'Senha',
                        controller: senha,
                        onSaved: onSaved,
                        obscure: true,
                      ),

                      SizedBox(height: 15),
                      CustomButtom(label:vm.isLogin? 'Entrar': 'Registrar', onTap: () => login(vm)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4,
                        children: [
                          Text(vm.isLogin?
                            'Ainda não faz parte?': 'Ja tem uma conta?',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => vm.toogleLoginRegister(),
                            child: Text( vm.isLogin?
                              'Crie uma conta!':'Faça Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
