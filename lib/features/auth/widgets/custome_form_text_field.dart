import 'package:flutter/material.dart';

class CustomeFormTextField extends StatelessWidget {
  const CustomeFormTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.labelText, 
  });

  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon , color: Theme.of(context).primaryColor,),
        border: const OutlineInputBorder(

          borderRadius: BorderRadius.all(Radius.circular(12), 
          
          ),
        ),
      ),
    );
  }
}
