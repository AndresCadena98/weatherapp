import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/models/validationIttem.dart';
import 'package:weatherapp/providers/state_login.dart';

class LoginViewModel extends ChangeNotifier {
  LoginState _state = LoginState();

  // Getters
  LoginState get state => _state;

  // Setters
   bool isValid(){

    
    if (_state.name.value.isEmpty || _state.name.error.isNotEmpty ) {
      return false;
    }
    return true;
  }

// Validaciones para el formato del nombre
 void setName(String name){
  
    if(name.isNotEmpty){
      _state = _state.copyWith(name:  ValidationItem(value: name ,error: ''));
    
    }else{
      _state = _state.copyWith(name: const ValidationItem(error: 'El campo está vacío'),);
    }
    
    notifyListeners();
  }

}
