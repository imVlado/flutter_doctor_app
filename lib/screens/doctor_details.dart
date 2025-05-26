
import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/components/button.dart';
import 'package:flutter_doctor_app/components/custom_appbar.dart';
import 'package:flutter_doctor_app/utils/api_config.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  //favorito button
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    //Obtener argumentos pasados desde doctor card
    final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: CustomAppbar(
        appTitle: "              Doctor Details",
        
  
        icon: const FaIcon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //pasar detalles del doctor aqui
            AboutDoctor(doctor: doctor,),
            //detalles del doctor
            DetailBody(doctor: doctor,),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Button(
                width: double.infinity,
                title: 'Book apointment',
                onPressed: () {
                  Navigator.of(context).pushNamed('booking_page',
                    arguments:{"doctor_id": doctor['doc_id']});
                },
                disable: false,
              ),
            )
          ],
        ),
      )
    );
  }
}


class AboutDoctor extends StatelessWidget {
  const AboutDoctor({super.key, required this.doctor});

  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65.0,
            backgroundImage: NetworkImage("${ApiConfig.baseUrl}/image/${doctor['doctor_profile'].split('/').last}"),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text(
            'Dr. ${doctor['doctor_name']}',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: Text(
              "UNAM (Universidad Nacional Autonoma de Maxico)",
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ) 
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: Text(
              "Hospital Horan",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            )
          )
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.doctor});
  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          //experiencia del doctor, pacientes y calificacion
          DoctorInfo(patients: doctor['patients'], exp: doctor['experience']),
          Config.spaceMedium,
          Text(
            'About Doctor',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              ),
            ),
            Config.spaceSmall,
            Text('Dr. ${doctor['doctor_name']} es un/una especialista en ${doctor['category']}, el/ella tiene mucha experiencia en su área.',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({super.key, required this.patients, required this.exp});

  final int patients;
  final int exp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InfoCard(
          label: "Patients",
          value: "$patients",
        ),
        const SizedBox(width: 15,),
        InfoCard(
          label: "Experience",
          value: "$exp years",
        ),
        const SizedBox(width: 15,),
        InfoCard(
          label: "Rating",
          value: "4.5",
        ),
      ],
    );
  }
}
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 22,
          horizontal: 1,
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}