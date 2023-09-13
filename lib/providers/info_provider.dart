
import 'package:flutter/material.dart';
import 'package:weatherapp/models/validationIttem.dart';
import 'package:weatherapp/providers/state_profile.dart';

class ProfileViewModel extends ChangeNotifier{
  ProfileState _state = ProfileState();

  // Getters
  ProfileState get state => _state;

  // Setters
  bool isValid(){
    if(_state.email.value.isEmpty ||
    _state.email.error.isNotEmpty ||
     _state.phone.value.isEmpty ||
     _state.phone.error.isNotEmpty ){
      return false;
    }
      return true;

  }

  //Validaciones para el formato del email
  void setEmail(String email){
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
    
    if(!emailValid){
      _state = _state.copyWith(email: const ValidationItem(error: 'El email no es valido'));
    }else if(email.length >= 3){
      _state = _state.copyWith(email: ValidationItem(value: email,error: ''));
    }else{
      _state = _state.copyWith(email: const ValidationItem(error: 'El email debe tener al menos 3 caracteres'),);
    }
    
    notifyListeners();
  }

  //Validaciones para el formato del telefono
  void setPhone(String password){
    if(password.length == 10){
        _state = _state.copyWith(password: ValidationItem(value: password,error: ''));
    }else{
      _state = _state.copyWith(password: const ValidationItem(error: 'El telefono debe tener 10 caracteres'));
    }
  
    notifyListeners();
  } 


  
} 