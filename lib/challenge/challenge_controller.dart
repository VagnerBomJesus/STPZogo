//CurrentPage

import 'dart:math';

import 'package:stpzogo/shared/models/question_model.dart';
import 'package:flutter/foundation.dart';

class ChallengeController {
  final currentPageNotifier = ValueNotifier<int>(1);
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int qtdAnwserRight = 0;
}


