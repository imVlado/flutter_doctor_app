//configuracion constante
import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  //inicializacion de  altura y ancho de pantalla
  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heightSize {
    return screenHeight;
  }

  //definir alturas de espaciado
  static const spaceSmall = SizedBox(height: 15,);
  static final spaceMedium = SizedBox(height: screenHeight! * 0.05,);
  static final spaceBig= SizedBox(height: screenHeight! * 0.08);

  //textfrom field border
  static const outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
  
  static const focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.blueAccent),
  );

  static const errorrBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.red),
  );

  static const primaryColor = Colors.blueAccent;
  

}