import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/components/button.dart';
import 'package:flutter_doctor_app/components/custom_appbar.dart';
import 'package:flutter_doctor_app/screens/booking_page.dart';
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
    return Scaffold(
      appBar: CustomAppbar(
        appTitle: "              Doctor Details",
        
  
        icon: const FaIcon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState((){
                isFav = !isFav;
              });
            },
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FaIcon(
                isFav ? Icons.favorite_rounded : Icons.favorite_outline,
                color: Colors.red,
                size: 30,
              ),
            ),    
          )
        ],
        
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AboutDoctor(),
            //detalles del doctor
            DetailBody(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Button(
                width: double.infinity,
                title: 'Book apointment',
                onPressed: () {
                  Navigator.of(context).pushNamed('booking_page');
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
  const AboutDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage("assets/doctor_2.jpg"),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text(
            'Dr. Ricardo Milos',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              "UNAM (Universidad Nacional Autonoma de Maxico)",
              style: TextStyle(
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
            child: const Text(
              "Hospital Horan",
              style: TextStyle(
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
  const DetailBody({super.key});

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
          const DoctorInfo(),
          Config.spaceMedium,
          const Text(
            'About Doctor',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              ),
            ),
            Config.spaceSmall,
            Text('Dr. Milos es un dentista experimentado en Nuevo Mexico, tiene multiples especialidades en medicina dental y cuidado bucal',
            style:  TextStyle(
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
  const DoctorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        InfoCard(
          label: "Patients",
          value: "109",
        ),
        SizedBox(width: 15,),
        InfoCard(
          label: "Experience",
          value: "10 years",
        ),
        SizedBox(width: 15,),
        InfoCard(
          label: "Rating",
          value: "9.3",
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