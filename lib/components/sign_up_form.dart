import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/Models/auth_model.dart';
import 'package:flutter_doctor_app/components/button.dart';
import 'package:flutter_doctor_app/main.dart';
import 'package:flutter_doctor_app/providers/dio_provider.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
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
            decoration:  InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                },
                icon:  obsecurePass
                  ? const Icon(
                    Icons.visibility_off_outlined,
                  color: Colors.black38,)
                  : const Icon(
                    Icons.visibility_off_outlined,
                    color: Config.primaryColor,)
              ),
            ),
          ),
          Config.spaceSmall,
          //login button
          Consumer<AuthModel>(
            builder:(context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sing Up',
                onPressed: () async {
                  print('Intentando registrar usuario...');
                  final userRegistration = await DioProvider().registerUser(
                    _nameController.text,
                    _emailController.text,
                    _passController.text
                  );
                  print('Resultado registro: $userRegistration');
                  if(userRegistration is bool && userRegistration){
                    print('Registro exitoso, intentando login...');
                    final token = await DioProvider().getToken(_emailController.text, _passController.text);
                    print('Resultado login: $token');
                    if(token == true){
                      print('Login exitoso, redireccionando...');
                      auth.loginSuccess();
                      MyApp.navigatorKey.currentState!.pushNamed('main');
                    } else {
                      print('Login después de registro falló: $token');
                    }
                  } else {
                    print('Registro fallido');
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