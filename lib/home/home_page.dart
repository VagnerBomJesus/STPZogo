import 'package:flutter/material.dart';
import 'package:stpzogo/challenge/challenge_page.dart';
import 'package:stpzogo/core/core.dart';
import 'package:stpzogo/home/widgets/appbar/app_bar_widget.dart';
import 'package:stpzogo/home/widgets/quiz_card/quiz_card_widget.dart';

import 'home_controller.dart';
import 'home_state.dart';
import 'widgets/level_button/level_button_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  String selectedLevel = "Fácil";

  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  int getTimerDuration(String level) {
    switch (level) {
      case "Fácil":
        return 1000; // Sem timer para nível Fácil
      case "Médio":
        return 30;
      case "Difícil":
        return 20;
      case "Perito":
        return 10;
      default:
        return 1000;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidget(
          user: controller.user!,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
             const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LevelButtonWidget(
                      label: "Fácil",
                      isSelected: selectedLevel == "Fácil",
                      onTap: () {
                        setState(() {
                          selectedLevel = "Fácil";
                        });
                      },
                    ),
                   const SizedBox(width: 8),
                    LevelButtonWidget(
                      label: "Médio",
                      isSelected: selectedLevel == "Médio",
                      onTap: () {
                        setState(() {
                          selectedLevel = "Médio";
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    LevelButtonWidget(
                      label: "Difícil",
                      isSelected: selectedLevel == "Difícil",
                      onTap: () {
                        setState(() {
                          selectedLevel = "Difícil";
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    LevelButtonWidget(
                      label: "Perito",
                      isSelected: selectedLevel == "Perito",
                      onTap: () {
                        setState(() {
                          selectedLevel = "Perito";
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  children: controller.quizzes!
                      .map((e) => QuizCardWidget(
                    title: e.title,
                    percent: e.questionAnswered / e.questions.length,
                    completed: "${e.questionAnswered}/${e.questions.length}",
                    onTap: () {
                      int timerDuration = getTimerDuration(selectedLevel);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChallengePage(
                            questions: e.questions,
                            title: e.title,
                            timerDuration: timerDuration,
                          ),
                        ),
                      );
                    },
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
