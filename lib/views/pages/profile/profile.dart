import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/blocs/bloc_saveInfo/save_info_bloc.dart';
import 'package:weatherapp/commons/colors.dart';
import 'package:weatherapp/providers/info_provider.dart';
import 'package:weatherapp/providers/login_provider.dart';
import 'package:weatherapp/views/widgets/buttonG.dart';
import 'package:weatherapp/views/widgets/textfieldG.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  String letter = '';
  String nameComplete = '';

  // Obtenemos la información del usuario
  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name') ?? '';
    var email = prefs.getString('email') ?? '';
    var phone = prefs.getString('phone') ?? '';
    setState(() {
      letter = name.substring(0, 1).toUpperCase();
      nameComplete = name;
      emailController.text = email;
      phoneController.text = phone;
    });
  }

  // Aviso para el usuario de que la información se guardó correctamente
  savedComplete() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Información guardada'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);
    ProfileViewModel viewModelProfile = Provider.of<ProfileViewModel>(context);
    var watch = context.watch<SaveInfoBloc>().state;

    if (watch is SaveInfoInitial) {
      if (watch.isSaved) {
        savedComplete();
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          height: 100,
        ),
        CircleAvatar(
          radius: 50,
          backgroundColor: colorPrimary,
          child: Text(
            letter,
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          'Bienvenido a tu perfil',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        Text(
          nameComplete,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        TextFieldGeneral(
            controller: emailController,
            error: viewModelProfile.state.email.error,
            hintText: 'Correo electrónico',
            icon: Icons.email,
            onChanged: (value) {
              viewModelProfile.setEmail(value);
            }),
        TextFieldGeneral(
            controller: phoneController,
            hintText: 'Número telefónico',
            icon: Icons.phone,
            onChanged: (value) {
              viewModelProfile.setPhone(value);
            }),
        ButtonGeneral(
            text: 'Guardar',
            onPressed: () {
              if (viewModelProfile.isValid()) {
                context.read<SaveInfoBloc>().add(SaveInfoProfile(
                    email: viewModelProfile.state.email.value,
                    phone: viewModelProfile.state.phone.value));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Los campos no son válidos'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            }),
        ButtonGeneral(
            text: 'Cerrar Sesión',
            onPressed: () async {
              // Eliminamos la información del usuario
              SharedPreferences prefs = await SharedPreferences.getInstance();
              //prefs.remove('name');
              prefs.remove('email');
              prefs.remove('phone');

              viewModel.setName('');

              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              });
            })
      ],
    );
  }
}
