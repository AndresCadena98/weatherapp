import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'switch_bio_event.dart';
part 'switch_bio_state.dart';

class SwitchBioBloc extends Bloc<SwitchBioEvent, SwitchBioState> {
  SwitchBioBloc()
      : super(SwitchBioInitial(
          isSwitched: false,
        )) {
    on<SwitchBioEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetSwitchBioInitialEvent>(_onSwitchBioInitialEvent);
    on<SetSwitchBioEvent>(_onSwitchBioEvent);
  }

  // Set para el SWITCH
  FutureOr<void> _onSwitchBioInitialEvent(
      GetSwitchBioInitialEvent event, Emitter<SwitchBioState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('isSwitched'));
    emit(SwitchBioInitial(isSwitched: prefs.getBool('isSwitched') ?? false));
  }

  // Get para el SWITCH
  FutureOr<void> _onSwitchBioEvent(
      SetSwitchBioEvent event, Emitter<SwitchBioState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isSwitched', event.isSwitched);
    emit(SwitchBioInitial(isSwitched: event.isSwitched, isAuth: true));
  }

 

  
}
