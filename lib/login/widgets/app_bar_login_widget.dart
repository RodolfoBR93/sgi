import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/app_text_styles.dart';

class AppBarLoginWidget extends PreferredSize {
  AppBarLoginWidget(double screenHeight)
      : super(
          preferredSize: Size.fromHeight(screenHeight * 30 / 100),
          child: SafeArea(
            top: true,
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                ),
                Container(
                  //child: Stack(
                  //children: [
                  //Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  width: double.maxFinite,

                  //decoration: BoxDecoration(gradient: AppGradients.linear),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Image.asset(
                            AppImages.logoColorida,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SISTEMA DE",
                                style: AppTextStyles.title,
                              ),
                              Text("GESTÃO", style: AppTextStyles.title),
                              Text("INTEGRADA", style: AppTextStyles.title),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
              ],
            ),
            // ),
            // ],
            //),
          ),
        );
}
