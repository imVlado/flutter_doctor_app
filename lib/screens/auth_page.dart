import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/components/login_form.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:flutter_doctor_app/utils/text.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State <AuthPage> createState() =>  _AuthPageState();
}

class  _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    //build login text field
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(
          horizontal:  15,
          vertical:  15,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppText.enText['welcome_text']!,
                style: const TextStyle(
                  fontSize:  36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              Text(
                AppText.enText['singIn_text']!,
                style: const TextStyle(
                  fontSize:  16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              //Componente del login
              LoginForm(),
              Config.spaceSmall,
              Center(
                child: TextButton(
                  onPressed:() {},
                  child: Text(
                    AppText.enText['forgot-password']!,
                    style: const TextStyle(
                      fontSize:  16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                  ),
                ),
                )
              )
            ]
          )
          ),
      ),
    );
  }
}