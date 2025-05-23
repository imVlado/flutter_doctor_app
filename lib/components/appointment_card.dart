import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/utils/api_config.dart';
import 'package:flutter_doctor_app/utils/config.dart';

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
              appointment: widget.doctor['appointment'],
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
                  onPressed: () {
                    
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
