part of './save_info_bloc.dart';

@immutable
abstract class SaveInfoEvent {}



class SaveInfoProfile extends SaveInfoEvent {
  final String email;
  final String phone;
  SaveInfoProfile({required this.email, required this.phone});
}


class GetSaveInfoInitialEvent extends SaveInfoEvent {

  GetSaveInfoInitialEvent();
}