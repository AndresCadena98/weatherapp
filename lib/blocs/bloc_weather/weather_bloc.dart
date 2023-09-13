import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/services/repository_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      // TODO: implement event handler
    });

on<GetWeather>(_getWeather);
  }
  
  FutureOr<void> _getWeather(GetWeather event, Emitter<WeatherState> emit)async{
    print('getWeather');
    emit(WeatherLoading());

      final weather = await WeatherRepository().getWeather(event.latitude, event.longitude);
      print(weather);
      emit(WeatherLoaded(weather));

  }
}

