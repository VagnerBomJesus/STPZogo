import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stpzogo/challenge/widgets/next_button/next_button_widget.dart';
import 'package:stpzogo/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:stpzogo/challenge/widgets/util/quiz_utils.dart';
import 'package:stpzogo/result/result_page.dart';
import 'package:stpzogo/shared/models/question_model.dart';

import 'challenge_controller.dart';
import 'widgets/quiz/quiz_widget.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;
  final int timerDuration; // Adicione o parâmetro de duração do timer

  ChallengePage({
    Key? key,
    required this.questions,
    required this.title,
    required this.timerDuration,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  List<QuestionModel> randomQuestions = [];
  late int timeLeft; // Tempo inicial do timer em segundos
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timeLeft = widget.timerDuration;
    randomQuestions = selectRandomQuestions(widget.questions, 5); // Selecione 5 questões aleatoriamente
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });

    // Iniciar o timer se a duração for maior que zero
    if (widget.timerDuration > 0) {
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
          handleTimeUp();
        }
      });
    });
  }

  void handleTimeUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Tempo esgotado!")),
    );
    goToResultPage();
  }

  void goToResultPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          result: controller.qtdAnwserRight,
          title: widget.title,
          length: randomQuestions.length,
        ),
      ),
    );
  }

  void nextPage() {
    if (controller.currentPage < randomQuestions.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    } else {
      goToResultPage();
    }
  }

  void onSelected(bool value) {
    if (value) {
      controller.qtdAnwserRight++;
    }
    nextPage();
  }

  @override
  void dispose() {
    timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: randomQuestions.length,
                ),
              )
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: randomQuestions
            .map(
              (question) => QuizWidget(
            question: question,
            onSelected: onSelected,
            onTimeUp: handleTimeUp,
            timerDuration: widget.timerDuration,
          ),
        )
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /*if (value < randomQuestions.length)
                  Expanded(
                    child: NextButtonWidget.white(
                      label: "Pular",
                      onTap: nextPage,
                    ),
                  ),*/
                /*if (value == randomQuestions.length)
                  Expanded(
                    child: NextButtonWidget.green(
                      label: "Confirmar",
                      onTap: goToResultPage,
                    ),
                  ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
