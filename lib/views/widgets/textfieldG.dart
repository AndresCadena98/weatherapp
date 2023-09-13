import 'package:flutter/material.dart';

import 'package:weatherapp/commons/colors.dart';




class TextFieldGeneral extends StatelessWidget {
  TextFieldGeneral({Key? key, required this.hintText, required this.icon, required this.onChanged, this.error,this.controller}) : super(key: key);
  final String hintText;
  IconData? icon;
  String? error;
  Function(String) onChanged;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
        keyboardType: hintText == 'Correo electrónico' ? TextInputType.emailAddress : hintText == 'Número telefónico' ? TextInputType.phone : TextInputType.text,
        controller: controller,
        onChanged: (value) => onChanged(value),
        style: const TextStyle(color: Colors.black),
        obscureText:  false,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.black),
          suffixIcon: Icon(icon, color: Colors.black,),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: colorPrimary)
          ),
          errorText: error,
          errorStyle: const TextStyle(color: Colors.red),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:  const BorderSide(color: colorPrimary)
          )
        ),
        
      ),
    );
  }
}