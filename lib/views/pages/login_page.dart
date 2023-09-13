import 'package:flutter/material.dart';
import 'package:weatherapp/commons/styles.dart';
import 'package:weatherapp/views/pages/login/content_login.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App Engine'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 50),
                Text('¡Bienvenido!',style: titleWelcome,),
                SizedBox(height: 50),
                ContentLogin(),
               
              ],
            ),
          ),
        ),
      ));
  }
}