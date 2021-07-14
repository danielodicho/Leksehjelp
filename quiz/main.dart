import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';
import "package:quiz_test/Pages.dart";




void main() async {
  subjectListHTML =
      await Chaleno().load('https://donekun.github.io/quiz-test/subject_list');
  runApp(MyApp());
}

