import 'package:flutter/material.dart';
import 'package:stpzogo/core/core.dart';

class LevelButtonWidget extends StatelessWidget {
  final String label;
  final bool isSelected; // Nova propriedade para indicar se está selecionado
  final VoidCallback onTap;

  LevelButtonWidget({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  })   : assert(["Fácil", "Médio", "Difícil", "Perito"].contains(label)),
        super(key: key);

  final config = {
    "Fácil": {
      "color": AppColors.levelButtonFacil,
      "borderColor": AppColors.levelButtonBorderFacil,
      "fontColor": AppColors.levelButtonTextFacil,
    },
    "Médio": {
      "color": AppColors.levelButtonMedio,
      "borderColor": AppColors.levelButtonBorderMedio,
      "fontColor": AppColors.levelButtonTextMedio,
    },
    "Difícil": {
      "color": AppColors.levelButtonDificil,
      "borderColor": AppColors.levelButtonBorderDificil,
      "fontColor": AppColors.levelButtonTextDificil,
    },
    "Perito": {
      "color": AppColors.levelButtonPerito,
      "borderColor": AppColors.levelButtonBorderPerito,
      "fontColor": AppColors.levelButtonTextPerito,
    },
  };

  Color get color => config[label]!['color']!;
  Color get borderColor => config[label]!['borderColor']!;
  Color get fontColor => config[label]!['fontColor']!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : color, // Cor de fundo mais intensa para o botão selecionado
          border: Border.fromBorderSide(BorderSide(
            color: isSelected ? Colors.deepPurple : borderColor, // Cor de borda mais intensa para o botão selecionado
          )),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : fontColor, // Texto branco se o botão estiver selecionado
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // Texto em negrito se o botão estiver selecionado
              fontFamily: 'NotoSans', // Fonte customizada especificada no pubspec.yaml
            ),
          )
        ),
      ),
    );
  }
}
