import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/blocs/bloc_swt/switch_bio_bloc.dart';

class SwitchListTileLogin extends StatefulWidget {
  const SwitchListTileLogin({super.key});

  @override
  _SwitchListTileLoginState createState() => _SwitchListTileLoginState();
}

class _SwitchListTileLoginState extends State<SwitchListTileLogin> {
  bool? isSwitched;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SwitchBioBloc>(context).add(GetSwitchBioInitialEvent());
    initBio();
  }

  Future<void> authenticate() async {
    final localAuth = LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await localAuth.authenticate(
        localizedReason: 'Por favor, autentícate para continuar',
      );
    } catch (e) {
      print(e);
    }

    if (authenticated) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      // La autenticación falló o el usuario canceló la autenticación.

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo autenticar'),
        ),
      );
    }
  }

  initBio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isSwitched = prefs.getBool('isSwitched') ?? false;
    var name = prefs.getString('name');
    if (isSwitched && name != null) {
      print('name: $name');
      authenticate();
    }
  }

  @override
  Widget build(BuildContext context) {
    var watch = context.watch<SwitchBioBloc>().state;
    if (watch is SwitchBioInitial) {
      isSwitched = watch.isSwitched;
    }

    return ListTile(
      title: const Text('Habilitar biométricos'),
      trailing: Switch(
        value: isSwitched!,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });

          BlocProvider.of<SwitchBioBloc>(context)
              .add(SetSwitchBioEvent(isSwitched: isSwitched!));
        },
      ),
    );
  }
}
