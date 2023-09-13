import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'save_info_event.dart';
part 'save_info_state.dart';
class SaveInfoBloc extends Bloc<SaveInfoEvent, SaveInfoState> {
  SaveInfoBloc() : super(SaveInfoInitial(
    email: '',
    phone: '',
  
  )) {
    on<SaveInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SaveInfoProfile>(_onSaveInfoProfile);
    on<GetSaveInfoInitialEvent>(_onGetSaveInfoInitialEvent);
}
  // Set para la info del perfil
  FutureOr<void> _onSaveInfoProfile(SaveInfoProfile event, Emitter<SaveInfoState> emit)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    

    prefs.setString('email', event.email);
    prefs.setString('phone', event.phone);
    emit(SaveInfoInitial(email: event.email, phone: event.phone,isSaved: true));
    
  }


  //Obtener Información del perfil
  FutureOr<void> _onGetSaveInfoInitialEvent(GetSaveInfoInitialEvent event, Emitter<SaveInfoState> emit)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var phone = prefs.getString('phone');
    emit(SaveInfoInitial(email: email!, phone: phone!, ));
  }
}