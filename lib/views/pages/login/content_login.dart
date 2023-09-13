import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/providers/login_provider.dart';
import 'package:weatherapp/views/widgets/buttonG.dart';
import 'package:weatherapp/views/widgets/switch.dart';
import 'package:weatherapp/views/widgets/textfieldG.dart';

class ContentLogin extends StatefulWidget {
  const ContentLogin({super.key});

  @override
  State<ContentLogin> createState() => _ContentLoginState();
}

class _ContentLoginState extends State<ContentLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          // Contenido del Login
          TextFieldGeneral(
              controller: nameController,
              hintText: 'Nombre',
              icon: Icons.person,
              error: viewModel.state.name.error,
              onChanged: (value) {
                viewModel.setName(value);
              }),
          Visibility(
            visible: viewModel.state.name.error.isEmpty,
            child: ButtonGeneral(
                text: 'Ingresar',
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  if (viewModel.isValid()) {
                    // Hacemos el set pára el nombre de la sesión
                    prefs.setString('name', nameController.text);
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, '/home');
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('El campo nombre es requerido'),
                      ),
                    );
                  }
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          const SwitchListTileLogin(),
        ],
      ),
    );
  }
}
