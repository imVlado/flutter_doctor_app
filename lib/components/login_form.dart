import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/components/button.dart';
import 'package:flutter_doctor_app/utils/config.dart';

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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child : Column(
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
          Button(
            width: double.infinity,
            title: 'Sing in',
            onPressed: (){
              //Sing in manual
              Navigator.of(context).pushNamed('main');
            },
            disable: false,
          )
        ],
        )
    );
  }
}