part of './save_info_bloc.dart';

@immutable
abstract class SaveInfoState {}

 class SaveInfoInitial extends SaveInfoState {
  String email;
  String phone;
  bool isSaved ;
  SaveInfoInitial({this.email = '', this.phone = '', this.isSaved = false});
  
 }
