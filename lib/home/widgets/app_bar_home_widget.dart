import 'dart:ui';
import 'package:charcode/ascii.dart';
import 'package:flutter/Material.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/app_gradients.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/app_text_styles.dart';

class AppBarRegisterWidget extends PreferredSize {
  AppBarRegisterWidget(
      double screenHeight, double screenWidth, VoidCallback onTapUpdate, String initials)
      : super(
          preferredSize: Size.fromHeight(250),
          child: Container(
            height: 250,
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
                  top: 40,
                  left: (screenWidth / 2) - 120,
                  child: Container(
                    child: Image.asset(
                      AppImages.logoBranca,
                      height: 80,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
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
                  top: 60,
                  right: 40,
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
                  alignment: Alignment(0.0, 2.0),
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 5, color: AppColors.white),
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white
                        // image: DecorationImage(
                        //   image: NetworkImage(
                        //       'https://p2.trrsf.com/image/fget/cf/460/0/images.terra.com/2021/06/06/111474860-loki-vote.jpg'),
                        // ),
                        ),
                    child: Center(
                      child: Text(
                        initials,
                        style: AppTextStyles.body24Blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
