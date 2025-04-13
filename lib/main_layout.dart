import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/screens/appointment_page.dart';
import 'package:flutter_doctor_app/screens/home_page.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  //declaracion de variables
  int currentPage = 0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value){
          setState(() {
            currentPage = value;
          });
        }),
        children: const <Widget>[
          HomePage(),
          AppointmentPage(),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Config.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        iconSize: 26,
        selectedFontSize: 15,
        unselectedFontSize: 13,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        elevation: 10,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: FaIcon(FontAwesomeIcons.houseChimneyMedical,),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: FaIcon(FontAwesomeIcons.solidCalendarCheck,),
            ),
            label: 'Appointment',
          ),
        ],
      ),
    );
  }
}