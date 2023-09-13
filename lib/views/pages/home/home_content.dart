import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/blocs/bloc_weather/weather_bloc.dart';
import 'package:weatherapp/commons/colors.dart';
import 'package:weatherapp/services/currentLocation.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  double longitude = 0;
  double latitude = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentLocation().then((value) {
      BlocProvider.of<WeatherBloc>(context)
          .add(GetWeather(value.split(',')[0], value.split(',')[1]));
    });
    
  }
 

  @override
  Widget build(BuildContext context) {
    var watch = context.watch<WeatherBloc>().state;

    if (watch is WeatherLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: colorPrimary,
        ),
      );
    }
    if (watch is WeatherLoaded) {
      var size = MediaQuery.of(context).size;

      return Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              getCurrentLocation().then((value) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(GetWeather(value.split(',')[0], value.split(',')[1]));
              });
            },
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: size.height,
                  width: size.width ,
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image: watch.weather.current!.isDay == 1?const AssetImage('assets/img/sunny.png',) : const AssetImage('assets/img/night.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          watch.weather.location!.name!,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${watch.weather.current!.tempC}°',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          watch.weather.current!.isDay == 1 ? 'Día' : 'Noche',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Image.network(
                          'https:${watch.weather.current!.condition!.icon}',
                          height: 100,
                          width: 100,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
            height: size.height * 0.3,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(DateFormat('EEEE').format(DateTime.parse(
                      watch.weather.forecast!.forecastday![0].date!)), style: const TextStyle(color: Colors.white),),
                  subtitle: Text(
                    'Moon phase : ${watch.weather.forecast!.forecastday!.last.astro!.moonPhase}°',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Feels like C ${watch.weather.current!.feelslikeC!}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Humidity : ${watch.weather.current!.humidity!}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Feels like F ${watch.weather.current!.feelslikeF!}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Weather : ${watch.weather.current!.condition!.text}',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          )
        ],
      );
      
    }
    return Container();
  }
}
