import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const CustomButtom({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary
        ),
        padding: const EdgeInsets.all(18),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
      ),
    );
  }
}