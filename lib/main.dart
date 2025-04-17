import 'package:flutter_doctor_app/main_layout.dart';
import 'package:flutter_doctor_app/screens/auth_page.dart';
import 'package:flutter_doctor_app/screens/booking_page.dart';
import 'package:flutter_doctor_app/screens/doctor_details.dart';
import 'package:flutter_doctor_app/screens/success_booked.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //esto es para hacer push en el navegador
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Doctor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //Predefine input decoration 
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorrBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(
            color: Config.primaryColor,
          ),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
          backgroundColor: Config.primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      routes: {
        //Esta es la ruta inicial de la app
        //Es la pagina de autenticacion
        '/': (context) => const AuthPage(),
        //Este es la pagina de inicio luego de la autenticacion
        'main': (context) => const MainLayout(),
        "doc_details": (context) => const DoctorDetails(),
        'booking_page': (context) => BookingPage(),
        'success_booking': (context) => const AppointmentBooked(),
      },
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Doctor App'),

      ),
    );
  }
}
