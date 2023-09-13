part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}


class GetWeather extends WeatherEvent {
  final String latitude;
  final String longitude;

  GetWeather(this.latitude, this.longitude);
}