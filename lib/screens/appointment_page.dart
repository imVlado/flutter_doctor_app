import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/utils/config.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

//enum para el estado de la cita
enum FilterStatus {
  upcoming,
  complete,
  cancel,
}

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming; //estado inicial
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      "doctor_name":"Ricardo Milos",
      "doctor_profile":"assets/doctor_2.jpg",
      "category":"Dental",
      "status": FilterStatus.upcoming,
    },
    {
      "doctor_name":"Carol G",
      "doctor_profile":"assets/doctor_2.jpg",
      "category":"Cardiology",
      "status":FilterStatus.complete,
    },
    {
      "doctor_name":"Elvis Presley",
      "doctor_profile":"assets/doctor_2.jpg",
      "category":"Respiration",
      "status":FilterStatus.complete,
    },
    {
      "doctor_name":"Freddy Mercury",
      "doctor_profile":"assets/doctor_2.jpg",
      "category":"General",
      "status":FilterStatus.cancel,
    }
  ];

  @override
  Widget build(BuildContext context) {
    //return cita filtrada
    List<dynamic> filteredSchedules = schedules.where((var schedule){
      // switch(schedule["status"]){
      //   case "upcoming":
      //     return filterStatus == FilterStatus.upcoming;
      //     break;
      //   case "complete":
      //     return filterStatus == FilterStatus.complete;
      //     break;
      //   case "cancel":
      //     return filterStatus == FilterStatus.cancel;
      //     break;
      // }
      return schedule["status"] == status;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Appointments Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //tabs de las citas
                      for(FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.upcoming) {
                                  status = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus == FilterStatus.complete) {
                                  status = FilterStatus.complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus == FilterStatus.cancel){
                                  status = FilterStatus.cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              }
                            );
                          },
                          child: Center(child:Text(filterStatus.name)),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Config.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  )
              ]
            ),
            Config.spaceSmall,
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: ((context, index){
                  var _schedule = filteredSchedules[index];
                  bool isLastElement = index == filteredSchedules.length + 1;
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: isLastElement ? Colors.transparent : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.grey[50],
                    elevation: 5,
                    shadowColor: Colors.grey,
                    margin: !isLastElement ? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(_schedule["doctor_profile"]),
                              ),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule["doctor_name"],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    _schedule["category"],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 15,),
                          //schedule card
                          const ScheduleCard(),
                          const SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: (){},
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Config.primaryColor,
                                      fontSize: 16,
                                    ),
                                  )
                                ),
                              ),
                              const SizedBox(width: 20,),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Config.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: (){},
                                  child: const Text(
                                    'Reschedule',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  )
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
                ),
            )
          ],
        ),
      )
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),

      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: const <Widget>[
          Icon(Icons.calendar_today,
            color: Config.primaryColor,
            size: 15
          ),
          SizedBox(width: 5,),
          Text(
            'Monday, 11/28/2025',
            style:  TextStyle(color: Config.primaryColor,),
          ),
          SizedBox(width: 20,),
          Icon(Icons.access_alarm,
            color: Config.primaryColor,
            size: 17
          ),
          SizedBox(width: 5,),
          Flexible(child: Text('2:00 PM', style: TextStyle(color: Config.primaryColor)),)
        ],
      ),
    );
  }
}
