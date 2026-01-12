import 'package:chat/core/auth/e_auth_state.dart';
import 'package:chat/core/router/app_router_static.dart';
import 'package:chat/view/auth_view/auth_view.dart';
import 'package:chat/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  // @override
  // void initState() {
    
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //         context.watch<AuthViewModel>().authState;
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    return StreamBuilder<EAuthState>(
      stream: vm.authState,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink(); // Ou um loading indicator
        }

        final authState = snapshot.data!;

        if (authState == EAuthState.authenticated) {
          // Navegar para home após o build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(AppRouterStatic.home);
          });
          return const SizedBox.shrink(); // Placeholder enquanto navega
        } else {
          // Não autenticado, mostrar AuthView
          return const AuthView();
        }
      },
    );
  }
}
