import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier{
  bool _isLogin = false;

  bool get isLogin {
    return _isLogin;
  }

  //cuando el inicio de sesion es exitoso, se actualiza el estado
  void loginSuccess(){
    _isLogin = true;
    notifyListeners();
  }
}