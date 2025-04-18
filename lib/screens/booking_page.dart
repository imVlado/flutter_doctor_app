import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/components/button.dart';
import 'package:flutter_doctor_app/components/custom_appbar.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State
<BookingPage> {
  
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: CustomAppbar(
        appTitle: '                Appointment',
        icon: const FaIcon(Icons.arrow_back_ios_new),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children:<Widget>[
                  _tableCalendar(),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: Center(
                      child: Text(
                        'Select Consultation Time',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    )
                ],
              ),
            ),
            _isWeekend
              ? SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                  alignment: Alignment.center,
                  child: Text(
                    'Weekend is not aviable, please select another date',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                )
              : SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index){
                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                        _timeSelected = true;
                      });
                    },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _currentIndex == index
                            ? Colors.white
                            : Colors.black
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: _currentIndex == index
                          ? Config.primaryColor
                          : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _currentIndex == index ? Colors.white : null,
                          )
                        ),
                      ),
                    );
                  },
                  childCount: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 1.5),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 150),
                    child: Button(
                      width: double.infinity,
                      title: 'Make Appointment',
                      onPressed: () {
                        Navigator.of(context).pushNamed('success_booking');
                      },
                      disable: _timeSelected && _dateSelected ? false : true,
                    ),
                  ),
                )
          ]
        ),
      )
      
    );
    
  }
  
  Widget _tableCalendar(){
    return TableCalendar(
      focusedDay: _focusDay ,
      firstDay: DateTime.now(),
      lastDay: DateTime(2025, 6, 16),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Config.primaryColor,
          shape: BoxShape.circle
        )
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged:(format) {
        setState(() {
          _format = format;
        },
      );},
      onDaySelected: ((selectedDay, focusedDay){
        setState(() {
          _focusDay = focusedDay;
          _currentDay = selectedDay;
          _dateSelected = true;

          //checa si es fin de semana
          if(selectedDay.weekday == 6 || selectedDay.weekday == 7){
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex= null;
          } else {
            _isWeekend = false;
          }

        });
      }),
    );
  }
}

