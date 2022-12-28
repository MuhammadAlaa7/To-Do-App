import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    backgroundColor: primaryClr,
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: white,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: darkHeaderClr,
      ),
    ),
  );

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    scaffoldBackgroundColor: darkHeaderClr,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: darkHeaderClr,
        statusBarIconBrightness: Brightness.light,
      ),
      color: darkHeaderClr,
      elevation: 0,
      iconTheme: IconThemeData(
        color: white,
      ),
    ),
  );
}

TextStyle get headline {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      //  color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subHeadLine {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      //color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get subTitle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      //  color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get bodyText {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      // color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get bodyText2 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      // color: Get.isDarkMode ? Colors.grey[400] : Colors.black,
    ),
  );
}
