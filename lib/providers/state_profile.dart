import 'package:weatherapp/models/validationIttem.dart';

class ProfileState {
  ValidationItem email;
  ValidationItem phone;

  ProfileState({
    this.email =  const ValidationItem(),
    this.phone = const ValidationItem(),
  });

  ProfileState copyWith({
    ValidationItem? email,
    ValidationItem? password,
  }) {
    return ProfileState(
      email: email ?? this.email,
      phone: password ?? this.phone,
    );
  }
}