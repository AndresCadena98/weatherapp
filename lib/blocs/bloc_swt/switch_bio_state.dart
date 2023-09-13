part of 'switch_bio_bloc.dart';

@immutable
abstract class SwitchBioState {}

 class SwitchBioInitial extends SwitchBioState {
  final bool isSwitched;
  final bool isAuth;
  SwitchBioInitial({required this.isSwitched, this.isAuth = false});
 }

 class NotBiometricAvailable extends SwitchBioState {

  NotBiometricAvailable();
 }

 
