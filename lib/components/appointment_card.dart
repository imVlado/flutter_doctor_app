import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/utils/config.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Config.primaryColor,
        borderRadius: BorderRadius.circular(10),
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
                  backgroundImage:
                  AssetImage("assets/doctor_1.jpeg"), //imagen doctor
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: const<Widget>[
                  Text('Dr. John Doe', style: TextStyle(color: Colors.white,),),
                  SizedBox(height: 2,),
                  Text('Dental', style: TextStyle(color: Colors.black,),
                  ),
                ],
              )
              ],
            ),
            Config.spaceSmall,
            //horario
            ScheduleCard(),
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
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent[700],
        borderRadius: BorderRadius.circular(10),

      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.calendar_today,
            color: Colors.white,
            size: 15
          ),
          SizedBox(width: 5,),
          Text(
            'Monday, 11/28/2025',
            style:  TextStyle(color: Colors.white,),
          ),
          SizedBox(width: 20,),
          Icon(Icons.access_alarm,
            color: Colors.white,
            size: 17
          ),
          SizedBox(width: 5,),
          Flexible(child: Text('2:00 PM', style: TextStyle(color: Colors.white)),)
        ],
      ),
    );
  }
}
