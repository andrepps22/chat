import 'package:flutter/material.dart';

class LoadView extends StatelessWidget {
  const LoadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              
            ),
            SizedBox(
              height: 10,
            ),
            Text('Carregando...', style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}