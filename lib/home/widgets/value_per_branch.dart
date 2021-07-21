import 'package:flutter/material.dart';
import 'package:sgi/approvals/paymentApprovals/getPayments.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/app_text_styles.dart';

class ValuePerBranch extends StatelessWidget {
  final String descricao;
  final String valor;
  final double rightV;
  final double leftV;

  ValuePerBranch(this.descricao, this.valor, this.rightV, this.leftV);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftV, 0, rightV, 8),
      child: Material(
        color: Colors.white,
        elevation: 6,
        borderRadius: BorderRadius.circular(10),
        child: Container(
            alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        descricao,
                        style: AppTextStyles.titleGray16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        valor,
                        style: AppTextStyles.lato24Blue,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
