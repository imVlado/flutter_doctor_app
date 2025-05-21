import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:flutter_doctor_app/utils/api_config.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({Key? key, required this.route, required this.doctor}) : super(key: key);

  final String route;
  final Map<String, dynamic> doctor; //Recibe los detalles de los doctores

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        
      ),
      
      height: 140,
      child: GestureDetector(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.33,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Image.network(
                    "${ApiConfig.baseUrl}/image/${doctor['doctor_profile'].split('/').last}",
                    fit: BoxFit.fill
                  ),
                ),
              ),
              Flexible(child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Dr. ${doctor['doctor_name']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${doctor['category']}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.star_border, color: Colors.yellow,size: 16),
                        Spacer(flex: 1,),
                        Text('4.5'),
                        Spacer(flex: 1,),
                        Text('Reviews'),
                        Spacer(flex: 1,),
                        Text('(20)'),
                        Spacer(flex: 7,),
                      ],
                    ),
                  ],
                ),
              ),)
            ],
          )
        ),
        onTap:() {
          //redirect to doctor details
          Navigator.of(context).pushNamed(route, arguments: doctor);
        },// Redireccion a detalles del doctor
      )
    );
  }
}