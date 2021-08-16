import 'dart:ui' as ui;
import 'package:charcode/ascii.dart';
import 'package:flutter/Material.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/app_gradients.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/app_text_styles.dart';

class AppBarRegisterWidget extends PreferredSize {
  AppBarRegisterWidget(double screenHeight, double screenWidth,
      ui.VoidCallback onTapUpdate, String initials, String expensesS,String expensesM,ui.VoidCallback onTapApproval)
      : super(
          preferredSize: Size.fromHeight((screenHeight * 30) / 100),
          child: Container(
            height: (screenHeight * 30) / 100,
            child: Stack(
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: AppColors.blue,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Color(0xFF4FACFE),
                          Color(0xFF00F2FE),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight < 800
                      ? (screenHeight * 2) / 100
                      : (screenHeight * 5) / 100,
                  left: (screenWidth / 2) - 120,
                  child: Container(
                    child: Image.asset(
                      AppImages.logoBranca,
                      height: 80,
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight < 800
                      ? (screenHeight * 3) / 100
                      : (screenHeight * 6) / 100,
                  left: screenWidth / 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SISTEMA DE",
                          style: AppTextStyles.titleWhite,
                        ),
                        Text("GESTÃO", style: AppTextStyles.titleWhite),
                        Text("INTEGRADA", style: AppTextStyles.titleWhite),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight < 800
                      ? (screenHeight * 4) / 100
                      : (screenHeight * 7) / 100,
                  right: screenHeight < 800
                      ? (screenHeight * 3) / 100
                      : (screenHeight * 4) / 100,
                  child: GestureDetector(
                    onTap: onTapUpdate,
                    child: Icon(
                      Icons.update,
                      size: 40,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.0, screenHeight < 600 ? 2.5 : 2.0),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 2),
                    child: Container(
                      height: 136,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.darkGrey, width: 2),
                      ),
                      child: Column(children: [Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Pendências",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.titleGray16,
                          ),
                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: GestureDetector(
                            onTap: onTapApproval,
                            child: Text(
                              expensesM,
                              textAlign: TextAlign.center,
                              style: (expensesS=='1' ? AppTextStyles.titleOrange18 : AppTextStyles.titleGreen18),
                            ),
                          ),
                          
                        ),
                      ),
                      ],)
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
