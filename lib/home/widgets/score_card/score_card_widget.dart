
import 'package:flutter/material.dart';
import 'package:stpzogo/core/core.dart';

class ScoreCardWidget extends StatelessWidget {
  final double percent;
  const ScoreCardWidget({Key? key, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Add ChartWidget here if needed
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
                    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                    children: [
                      Text(
                        "São Tomé e Principe",
                        style: AppTextStyles.heading,
                        textAlign: TextAlign.center, // Adiciona alinhamento central ao texto
                      ),
                      SizedBox(height: 16,),
                      Text(
                        "Jogue, aprenda e apaixone-se pela Ilha do Leve-Leve!",
                        style: AppTextStyles.bodyBold,
                        textAlign: TextAlign.center, // Adiciona alinhamento central ao texto
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
