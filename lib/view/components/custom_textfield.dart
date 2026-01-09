import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String?) onSaved;
  final bool obscure;
  const CustomTextfield({
    super.key,
    required this.label,
    required this.controller,
    required this.onSaved,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Theme.of(context).colorScheme.tertiary,
        filled: true,
        hint: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
      ),
      onSaved: onSaved,
    );
  }
}
