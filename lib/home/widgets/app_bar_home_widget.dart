import 'dart:ui';
import 'package:charcode/ascii.dart';
import 'package:flutter/Material.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/app_gradients.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/app_text_styles.dart';

class AppBarRegisterWidget extends PreferredSize {
  AppBarRegisterWidget(double screenHeight, double screenWidth,
      VoidCallback onTapUpdate, String initials)
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
                  child: Container(
                    height:  screenHeight < 600 ? 100 : 130,
                    width: screenHeight < 600 ? 100 : 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 5, color: AppColors.white),
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.orange,
                        // image: DecorationImage(
                        //   image: NetworkImage(
                        //       'https://p2.trrsf.com/image/fget/cf/460/0/images.terra.com/2021/06/06/111474860-loki-vote.jpg'),
                        // ),
                        ),
                    child: Center(
                      child: Text(
                        initials,
                        style: AppTextStyles.text30White,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
