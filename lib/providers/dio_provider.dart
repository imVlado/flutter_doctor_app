import "dart:convert";
import "package:dio/dio.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:flutter_doctor_app/utils/api_config.dart';

class DioProvider {
//Obtener Token
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await Dio().post('${ApiConfig.baseUrl}/api/login',
        data: {'email': email, 'password': password});
      
      //Si la peticion es exitosa, retorna el token
      if (response.statusCode == 200 && response.data != '') {
        //guarda el token retornado en share preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  //obtener datos del usuario
  Future<dynamic> getUser(String token) async {
    try {
      var user = await Dio().get('${ApiConfig.baseUrl}/api/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

      //si la petición es correcta, se retorna la información del usuario
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      return error;
    }
  }

  //registra un nuevo usuario
  Future<dynamic> registerUser(String username, String email, String password) async {
    try {
      var user = await Dio().post('${ApiConfig.baseUrl}/api/register',
        data: {'name': username, 'email': email, 'password': password});

      //si el registro es correcto, se retorna true
      if ((user.statusCode == 200 || user.statusCode == 201) && user.data != '') {
        return true;
      }else{
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  //Guardar detalles de reservacion
  Future<dynamic> bookAppointment(
    String date, String day, String time, int doctor, String token
  ) async {
    try{
      var response = await Dio().post('${ApiConfig.baseUrl}/api/book',
      data: {'date': date, 'day': day, 'time': time, 'doctor_id': doctor},
      options: Options(headers: {'Authorization': 'Bearer $token'}));

      if(response.statusCode == 200 && response.data != 'data') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //Recupera los detalles de reservacion
  Future<dynamic> getAppointments(String token) async {
    try {
      var response = await Dio().get('${ApiConfig.baseUrl}/api/appointments',
      options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return json.encode(response.data);
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }
}