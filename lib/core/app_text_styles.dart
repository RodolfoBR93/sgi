import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle title = GoogleFonts.roboto(
    color: AppColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle titleWhite = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle titleGray16 = GoogleFonts.roboto(
    color: AppColors.lightGrey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle forgotPassword = GoogleFonts.notoSans(
    color: AppColors.blue,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle title15Black = GoogleFonts.workSans(
    color: AppColors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle title13Grey = GoogleFonts.workSans(
    //color: AppColors.darkGrey,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle title13Red = GoogleFonts.workSans(
    color: AppColors.red,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle title13Green = GoogleFonts.workSans(
    color: AppColors.darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle title13Orange = GoogleFonts.workSans(
    color: AppColors.orange,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle body15 = GoogleFonts.roboto(
    color: AppColors.blue,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body16Blue = GoogleFonts.roboto(
    color: AppColors.blue,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body16White = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body30Black = GoogleFonts.roboto(
    color: AppColors.black,
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body24Blue = GoogleFonts.roboto(
    color: AppColors.blue,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

    static final TextStyle lato24Blue = GoogleFonts.lato(
    color: AppColors.blue,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );


  static final TextStyle body20Blue = GoogleFonts.roboto(
    color: AppColors.blue,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}
