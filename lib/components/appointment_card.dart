import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/main.dart';
import 'package:flutter_doctor_app/providers/dio_provider.dart';
import 'package:flutter_doctor_app/utils/api_config.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key, required this.doctor, required this.color});

  final Map<String, dynamic> doctor;
  final Color color;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
      ),

      child : Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${ApiConfig.baseUrl}/image/${widget.doctor['doctor_profile'].split('/').last}"
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Dr. ${widget.doctor['doctor_name']}',
                    style: const TextStyle(color: Colors.white,),),
                  SizedBox(height: 2,),
                  Text(widget.doctor['category'],
                    style: const TextStyle(color: Colors.black,),
                  ),
                ],
              )
              ],
            ),
            Config.spaceSmall,
            //horario
            ScheduleCard(
              appointment: widget.doctor['appointments'],
            ),
            Config.spaceSmall,
            //boton de accion
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    
                  },
                ),
                ),
                const SizedBox(width: 20,),
                Expanded(child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  


                  child: const Text(
                    'Completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () async{
                    showDialog(
                      context: context,
                      builder: (context){
                        return RatingDialog(
                          initialRating: 1.0,
                          title: const Text('Rate the doctor',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                            ),
                          message: const Text('Please help us rating our doctor',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                            ),
                          image: const FlutterLogo(size: 100,),
                          submitButtonText: 'Submit',
                          
                          commentHint: 'Your review',
                          
                          onSubmitted: (response) async{
                            final SharedPreferences prefs=
                              await SharedPreferences.getInstance();
                            final token =
                              prefs.getString('token') ?? '';

                              final rating = await DioProvider()
                                .storeReviews(
                                  response.comment,
                                  response.rating,
                                  widget.doctor['appointments']['id'],
                                  widget.doctor['doc_id'],
                                  token
                                );

                                // verifica si la respuesta es correcta
                                if(rating == 200 && rating != '') {
                                  MyApp.navigatorKey.currentState!
                                    .pushNamed('main');
                                }
                              
                          },
                          
                      );
                    });
                  },
                ),
                ),
              ],
            )
            ],
          ),
        )
      ),
    );
  }
}


//Horario
class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.appointment});
  final Map<String, dynamic> appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),

      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(Icons.calendar_today,
            color: Config.primaryColor,
            size: 20
          ),
          SizedBox(width: 5,),
          Text(
            '${appointment['day']}, ${appointment['date']}',
            style: const TextStyle(
              color: Config.primaryColor, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 20,),
          const Icon(Icons.access_alarm,
            color: Config.primaryColor,
            size: 20
          ),
          SizedBox(width: 5,),
          Flexible(child: Text(
          appointment['time'], 
          style: const TextStyle(
            color: Config.primaryColor,
            fontWeight: FontWeight.w500,
            )),)
        ],
      ),
    );
  }
}
