import 'package:flutter/material.dart';
import 'package:flutter_doctor_app/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppbar({super.key, this.appTitle, this.route, this.icon, this. actions });

  @override
  Size get preferredSize => const Size.fromHeight(60); //alto del appbar

  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        widget.appTitle!,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      //devuelve null si no hay icon
      leading: widget.icon != null ? Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Config.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          icon: widget.icon!,
          onPressed: () {
            //si hay ruta, navega a la ruta
            if(widget.route != null) {
              Navigator.of(context).pushNamed(widget.route!);
            } else {
              //si no hay ruta, regresa a la pantalla anterior
              Navigator.pop(context);
            }
          },
          iconSize: 16,
          color: Colors.white,
        ),
      ) : null,
      //si no hay accionres, regresa null
      actions: widget.actions ?? null,
    );
  }
}