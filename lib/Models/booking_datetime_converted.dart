import 'package:intl/intl.dart';


//Convierte date/day/time del calendario a un string
class DateConverted {
  static String getDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  static  String getDay(int day) {
    switch (day) {
      case 1:
      return 'Monday';
      case 2:
      return 'Tuesday';
      case 3:
      return '';
      case 4:
      return 'Wednesday';
      case 5:
      return 'Thursday';
      case 6:
      return 'Saturday';
      case 7:
      return 'Sunday';
      default:
      return 'Sunday';
    }
  }

  static String getTime(int time) {
    switch(time){
      case 0:
      return '9:00 AM';
      case 1:
      return '10:00 AM';
      case 2:
      return '11:00 AM';
      case 3:
      return '12:00 AM';
      case 4:
      return '13:00 AM';
      case 5:
      return '14:00 AM';
      case 6:
      return '15:00 AM';
      case 7:
      return '16:00 AM';
      default:
      return '9:00 AM';
    }
  }
}