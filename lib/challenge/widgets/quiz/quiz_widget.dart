import 'package:flutter/material.dart';
import 'dart:async';

import 'package:stpzogo/challenge/widgets/awnser/awnser_widget.dart';
import 'package:stpzogo/core/core.dart';
import 'package:stpzogo/shared/models/awnser_model.dart';
import 'package:stpzogo/shared/models/question_model.dart';

class QuizWidget extends StatefulWidget {
  final QuestionModel question;
  final ValueChanged<bool> onSelected;
  final VoidCallback onTimeUp;
  final int timerDuration; // Tempo máximo do timer em segundos

  const QuizWidget({
    Key? key,
    required this.question,
    required this.onSelected,
    required this.onTimeUp,
    required this.timerDuration,
  }) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int indexSelected = -1;
  late int timeLeft; // Tempo inicial do timer em segundos
  Timer? timer;

  AwnserModel awnser(int index) => widget.question.awnsers[index];

  @override
  void initState() {
    super.initState();
    timeLeft = widget.timerDuration;
    if (timeLeft != 1000) {
      startTimer();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          widget.onTimeUp();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        if (timeLeft !=
            1000) // Exibir o Timer apenas se timeLeft for diferente de 1000
          Container(
            decoration: BoxDecoration(
              color: timeLeft <= widget.timerDuration * 0.45 ? AppColors.darkRed : AppColors.darkGreen,
              shape: BoxShape.circle,

            ),
            padding: const EdgeInsets.all(0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: timeLeft / widget.timerDuration,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      timeLeft <= widget.timerDuration * 0.45 ? AppColors.darkRed : AppColors.darkGreen,
                    ),
                    strokeWidth: 8.0, // Ajuste a largura do círculo aqui
                  ),
                ),
                Text(
                  "$timeLeft",
                  style: AppTextStyles.titleBold.copyWith(color: AppColors.white), // Texto branco para contraste
                ),
              ],
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.question.title,
            style: AppTextStyles.heading,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        for (var i = 0; i < widget.question.awnsers.length; i++)
          AwnserWidget(
            anwser: awnser(i),
            disabled: indexSelected != -1,
            isSelected: indexSelected == i,
            onTap: (value) {
              indexSelected = i;
              setState(() {});
              timer?.cancel(); // Cancelar o timer ao selecionar uma resposta
              Future.delayed(const Duration(seconds: 1))
                  .then((_) => widget.onSelected(value));
            },
          ),
      ],
    );
  }
}
