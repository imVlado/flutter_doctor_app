import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/components/appointment_card.dart';
import 'package:flutter_doctor_app/components/doctor_card.dart';
import 'package:flutter_doctor_app/providers/dio_provider.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctor = {};
  List<Map<String, dynamic>> medCat = [
    {
      "category":"General",
      "icon":FontAwesomeIcons.userDoctor,
    },
    {
      "category":"Cardiologist",
      "icon":FontAwesomeIcons.heartPulse,
    },
    {
      "category":"Respiratory",
      "icon":FontAwesomeIcons.lungs,
    },
    {
      "category":"Dermatology",
      "icon":FontAwesomeIcons.hand,
    },
    {
      "category":"Gynecology",
      "icon":FontAwesomeIcons.personPregnant,
    },
    {
      "category":"Dental",
      "icon":FontAwesomeIcons.teeth,
    },
  ];

  Future<void> getData() async {
    //obtener token de share preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    
    if (token.isNotEmpty && token != '') {
      final response = await DioProvider().getUser(token);
      if (response != null) {
        setState(() {
          //Decodificación Json
          user = json.decode(response);
          
          //Checa si hay alguna reservacion hoy
          for(var doctorData in user['doctor']){
            if(doctorData['appointments'] != null) {
              doctor = doctorData;
            }
          }
        });
      }
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Elimina el token almacenado
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false); // Redirige al login
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      //si el usuario está vacío, entonces retorna el indicador de progreso
      body: user.isEmpty ?
      const Center(child: CircularProgressIndicator(),)
      : Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      user['name'] ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: logout,
                          tooltip: 'Logout',
                        ),
                        const SizedBox(width: 10),
                        const SizedBox(
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage('assets/profile1.png'),
                          ),
                        ),
                        
                      ],
                    )
                  ],
                ),
                Config.spaceMedium,
                //listado de categorias
                const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                Config.spaceSmall,
                SizedBox(
                  height: Config.heightSize* 0.05,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(medCat.length,(index){
                      return Card(
                        margin: const EdgeInsets.only(right: 10),
                        color: Config.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              FaIcon(
                                medCat[index]['icon'],
                                color: Colors.white,
                              ),
                              const SizedBox(width: 20,),
                              Text(
                                medCat[index]['category'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )
                        )
                      );
                    })
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Appointment Today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                //listado de citas
                doctor.isNotEmpty
                ? AppointmentCard(doctor: doctor, color: Config.primaryColor,)
                : Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No Appointment Today',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Top Doctors',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                //listado de doctores top
                Column(
                  children: List.generate(user['doctor'].length, (index){
                    return DoctorCard(
                      route: 'doc_details',
                      doctor: user['doctor'][index],
                    );
                  }),
                )
              ],
            ),
          ) ,)
      ),
    );
  }
}