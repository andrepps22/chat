import 'package:chat/core/router/app_router_static.dart';
import 'package:chat/data/domain/DTOs/user_dto.dart';
import 'package:chat/view/components/custom_buttom.dart';
import 'package:chat/view/components/custom_textfield.dart';
import 'package:chat/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key, });

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  
  void onSaved(String? string){}
  

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
                Icon(Icons.message, size: 50, color: Theme.of(context).colorScheme.primary,),
                SizedBox(height: 50,),
                Form(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [                  
                    CustomTextfield(label: 'Email',controller: email, onSaved: onSaved ),
                    CustomTextfield(label: 'Senha',controller: senha, onSaved: onSaved , obscure: true,),
                    
                    SizedBox(height: 15,),
                    CustomButtom(label: 'Entrar', onTap: (){
                      
                        vm.userDto = UserDto(email: email.text, password: senha.text);
                        vm.login();

                        if(vm.islogged){
                          Navigator.of(context).pushNamed(AppRouterStatic.home);
                        }
                      
                    },),
                    SizedBox(height: 10,),
                    TextButton(onPressed: (){}, child: Text('Criar uma nova conta', style: TextStyle(color: Theme.of(context).colorScheme.primary),),)
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}