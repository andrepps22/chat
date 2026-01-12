import 'package:chat/core/auth/e_auth_state.dart';
import 'package:chat/core/router/app_router_static.dart';
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
          return const SizedBox.shrink();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (snapshot.data == EAuthState.authenticated) {
            Navigator.of(context).pushReplacementNamed(AppRouterStatic.home);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRouterStatic.login);
          }
        });

        return const SizedBox.shrink();
      },
    );
  }
}
