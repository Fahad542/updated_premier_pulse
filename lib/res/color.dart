
import 'package:flutter/material.dart';
import '../utils/hexcolor_base.dart';



class AppColors {

  static const Color blackColor = Color(0xFF00000);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color ligthgreen = Colors.green;
  static  Color ligthgreenshade = Colors.green.shade100;
  static  Color greenboxshade = Colors.green.shade100;
  static const Color greencolor = Color(0xFF1D2F4A);
  static const Color lightGreenColor = Color(0xFFC8E6C9);
  static HexColor primary = HexColor("#135285");
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF135285,
    <int, Color>{
      50: Color(0xFFE3EAF1),
      100: Color(0xFFB9CADD),
      200: Color(0xFF8DA8C6),
      300: Color(0xFF6286B0),
      400: Color(0xFF406DA0),
      500: Color(0xFF135285), // base color
      600: Color(0xFF114B7B),
      700: Color(0xFF0E4170),
      800: Color(0xFF0B3966),
      900: Color(0xFF062A53),
    },
  );
  static const Color lightGrey = Color(0xFFD3D3D3);
  static const Color buttonColor = Colors.green;
  static var black;
  static var white;

}