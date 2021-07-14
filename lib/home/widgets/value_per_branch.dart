import 'package:flutter/material.dart';
import 'package:sgi/approvals/paymentApprovals/getPayments.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/app_text_styles.dart';

class ValuePerBranch extends StatelessWidget {
  final String descricao;
  final String valor;

  ValuePerBranch(this.descricao, this.valor);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child:Container(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(color: AppColors.darkGrey),
        ),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              descricao,
              style: AppTextStyles.titleGray16,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              valor,
              style: AppTextStyles.lato24Blue,
              textAlign: TextAlign.left,
            ),
            
          ],
        ),
      ),
    ),);
  }
}
