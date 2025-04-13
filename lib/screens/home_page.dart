import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/components/appointment_card.dart';
import 'package:flutter_doctor_app/components/doctor_card.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
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
                  children: const <Widget>[
                    Text(
                      'Gerardo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/profile1.jpg'),
                      ),
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
                  'Appointment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                //listado de citas
                AppointmentCard(),
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
                  children: List.generate(10, (index){
                    return const DoctorCard();
                  }),
                )
              ],
            ),
          ) ,)
      ),
    );
  }
}