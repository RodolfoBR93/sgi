import 'dart:ui';

import 'package:charcode/ascii.dart';
import 'package:flutter/Material.dart';
import 'package:sgi/core/app_gradients.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/app_text_styles.dart';

class AppBarRegisterWidget extends PreferredSize {
  AppBarRegisterWidget()
      : super(
          preferredSize: Size.fromHeight(250),
          child: Container(
            height: 250,
            child: Stack(
              children: [
                Container(
                  height: 161,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  decoration: BoxDecoration(gradient: AppGradients.linear),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(TextSpan(
                          text: "Olá, ",
                          style: AppTextStyles.titleWhite,
                          children: [
                            TextSpan(
                              text: "Rodolfo",
                              style: AppTextStyles.titleWhite,
                            )
                          ])),
                      Container(
                        height: 58,
                        width: 58,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://avatars.githubusercontent.com/u/7799803?s=400&u=c95f9171ed77b57d04ce8fb732a48b8579af0c09&v=4'))),
                      )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        );
}
