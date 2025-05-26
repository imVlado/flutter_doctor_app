import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/Models/auth_model.dart';
import 'package:flutter_doctor_app/components/button.dart';
import 'package:flutter_doctor_app/main.dart';
import 'package:flutter_doctor_app/providers/dio_provider.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  
  // Función para mostrar mensaje de error
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Adress',
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                },
                icon: obsecurePass
                  ? const Icon(
                    Icons.visibility_off_outlined,
                    color: Colors.black38,)
                  : const Icon(
                    Icons.visibility_outlined,  // Corregí este icono
                    color: Config.primaryColor,)
              ),
            ),
          ),
          Config.spaceSmall,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign in',
                onPressed: () async {
                  // Verificar que los campos no estén vacíos
                  if (_emailController.text.isEmpty || _passController.text.isEmpty) {
                    _showErrorSnackBar('Por favor ingresa email y contraseña');
                    return;
                  }

                  try {
                    final token = await DioProvider().getToken(
                      _emailController.text, 
                      _passController.text
                    );

                    if (token == true) {
                      auth.loginSuccess();
                      MyApp.navigatorKey.currentState?.pushNamed('main');
                    } else {
                      _showErrorSnackBar('Credenciales incorrectas');
                    }
                  } catch (e) {
                    _showErrorSnackBar('Error al iniciar sesión');
                  }
                },
                disable: false,
              );
            },
          )
        ],
      )
    );
  }
}