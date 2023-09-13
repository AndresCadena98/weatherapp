part of 'switch_bio_bloc.dart';

@immutable
abstract class SwitchBioEvent {}


class GetSwitchBioInitialEvent extends SwitchBioEvent {

  GetSwitchBioInitialEvent();
}

class SetSwitchBioEvent extends SwitchBioEvent {
  final bool isSwitched;
  final bool isAuth;
  SetSwitchBioEvent({required this.isSwitched, this.isAuth = false});
}

