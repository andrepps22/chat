import 'package:chat/view/components/custom_buttom.dart';
import 'package:chat/view/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  final VoidCallback funcao;
  const AuthView({super.key, required this.funcao});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final TextEditingController nome = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  
  void onSaved(String? string){}
  

  @override
  Widget build(BuildContext context) {
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
                    CustomButtom(label: 'Entrar', onTap: widget.funcao,),
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