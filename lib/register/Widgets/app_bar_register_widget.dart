import 'dart:ui';

import 'package:charcode/ascii.dart';
import 'package:flutter/Material.dart';
import 'package:sgi/core/app_gradients.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/app_text_styles.dart';

class AppBarRegisterWidget extends PreferredSize {
  AppBarRegisterWidget()
      : super(
          preferredSize: Size.fromHeight(120),
          child: SafeArea(
            top: true,
            child: Column(
              children: [
                Container(
                  //child: Stack(
                  //children: [
                  //Container(
                  decoration: BoxDecoration(gradient: AppGradients.linear),
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  width: double.maxFinite,
                  //decoration: BoxDecoration(gradient: AppGradients.linear),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Container(
                            child: Image.asset(
                              AppImages.logoBranca,
                              height: 80,
                            ),
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
                                style: AppTextStyles.titleWhite,
                              ),
                              Text("GESTÃO", style: AppTextStyles.titleWhite),
                              Text("INTEGRADA",
                                  style: AppTextStyles.titleWhite),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ),
            // ],
            //),
          ),
        );
}
