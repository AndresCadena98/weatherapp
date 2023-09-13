import 'package:weatherapp/models/validationIttem.dart';

class LoginState {
  ValidationItem name;
 

  LoginState({
    this.name = const ValidationItem(),
    
  });

  LoginState copyWith({
    ValidationItem? name,
  
  }) {
    return LoginState(
      name: name ?? this.name,
    
    );
  }
}