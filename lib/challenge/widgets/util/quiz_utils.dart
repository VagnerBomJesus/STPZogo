import 'dart:math';
import 'package:stpzogo/shared/models/question_model.dart';

List<QuestionModel> selectRandomQuestions(List<QuestionModel> questions, int count) {
  final random = Random();
  if (questions.length <= count) {
    return questions;
  }
  List<QuestionModel> shuffledQuestions = List<QuestionModel>.from(questions)..shuffle(random);
  return shuffledQuestions.take(count).toList();
}
