import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stpzogo/core/core.dart';
import 'package:stpzogo/home/widgets/score_card/score_card_widget.dart';
import 'package:stpzogo/shared/models/user_model.dart';

class AppBarWidget extends PreferredSize {
  final UserModel user;
  AppBarWidget({super.key, required this.user})
      : super(
    preferredSize: const Size.fromHeight(250),
    child: SizedBox(
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 161,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.maxFinite,
            decoration: const BoxDecoration(gradient: AppGradients.linear),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                    text: "   ",
                    style: AppTextStyles.title,
                    children: [
                      TextSpan(
                        text: user.name,
                        style: AppTextStyles.titleBold,
                      )
                    ])),
                // Aqui você pode adicionar seu IconButton dentro de um Row se precisar de mais botões
                PopupMenuButton<int>(
                  icon: const Icon(Icons.more_vert_outlined, size: 30, color: AppColors.white),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                       value: 1,
                      child: Text("Ação 1"),
                    ),
                   const PopupMenuItem(
                      value: 2,
                      child: Text("Sobre"),
                    ),
                    // Adicione mais itens se necessário
                  ],
                  onSelected: (value) {
                    // Aqui você pode implementar o que acontecerá quando um item for selecionado
                  },
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment(0.0, 1.0),
              child: ScoreCardWidget(
                percent: user.score / 100,
              ))
        ],
      ),
    ),
  );
}
