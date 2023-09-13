import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/blocs/bloc_saveInfo/save_info_bloc.dart';
import 'package:weatherapp/blocs/bloc_weather/weather_bloc.dart';
import 'package:weatherapp/providers/info_provider.dart';
import 'package:weatherapp/providers/state_login.dart';
import 'package:weatherapp/views/pages/home_page.dart';
import 'package:weatherapp/views/pages/login_page.dart';

import 'blocs/bloc_swt/switch_bio_bloc.dart';
import 'providers/login_provider.dart';

String nameGeneral = '';
void main() async {
  // Obtenemos el valor de la sesión guardada
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var name = prefs.getString('name') ?? '';
  nameGeneral = name;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        BlocProvider(create: (_) => SwitchBioBloc()),
        BlocProvider(create: (_) => SaveInfoBloc()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        BlocProvider(create: (_) => WeatherBloc()),
      ],
      child: MaterialApp(
        
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: nameGeneral.isEmpty ? const LoginPage() : const HomePage(),
          routes: {
            '/login': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
          }),
    );
  }
}
