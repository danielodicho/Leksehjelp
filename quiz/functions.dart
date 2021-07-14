import 'package:flutter/material.dart';
import 'dart:math';
import 'package:chaleno/chaleno.dart';

var score = 0;
var answeredRight  = true;
void changeHomo;
var counter = 1;
var nextButtonString = "Next";
var numQuestions = 3;
// ignore: top_level_function_literal_block
var quizPageSetState;
var questionColumn;
var placeHolderWidget = <Widget>[];
var questionDocument;
var title = "Can you get the question right?";

var questionOrder = [];
// ignore: top_level_function_literal_block
var loadQuestions = (quiz) async {
  questionOrder = [];
  questionDocument = await Chaleno().load('https://donekun.github.io/quiz-test/${quiz.replaceAll(" ", "_")}');
  numQuestions = questionDocument.getElementsByTagName("h").length;
  for (int i = 1; i<=numQuestions; i++ ) {
    // ignore: unnecessary_statements
    questionOrder.add(i);
  }

  questionOrder = shuffle(questionOrder);
  questionColumn = questionsCreate("question${questionOrder[0]}");
};


List shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {

    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

// ignore: top_level_function_literal_block
var wrongAnswer = (index,questionAlternativeTextLocal,wrongColor) {
  return Container(
      child: ElevatedButton(child: questionAlternativeTextLocal, onPressed: () {
        title = "Hahaha you dumb as fuck";
        answeredRight = false;
        placeHolderWidget[index] = wrongAnswer(index,questionAlternativeTextLocal, Colors.red);
        questionColumn[1] = Column(children: placeHolderWidget);
        quizPageSetState();
      }
          ,style: ElevatedButton.styleFrom(primary: wrongColor)
      ),
      margin: EdgeInsets.all(10)
  );
};

// ignore: top_level_function_literal_block
var rightAnswer = (index,nah,rightColor) {
  // ignore: top_level_function_literal_block, top_level_function_literal_block
  return Container(
      child: ElevatedButton(child: nah, onPressed: () {
        title = "You smart af";
        if (answeredRight)
        {score+=1;}
        answeredRight = false;
        placeHolderWidget[index] = rightAnswer(index,nah, Colors.green);
        questionColumn[1] = Column(children: placeHolderWidget);
        quizPageSetState();
      },style: ElevatedButton.styleFrom(primary: rightColor) ),
      margin: EdgeInsets.all(10)
  );
};

// ignore: non_constant_identifier_names, top_level_function_literal_block
var questionsCreate = (className) {
  placeHolderWidget = <Widget>[];
  var questionAlternativeListHTML = questionDocument.getElementsByClassName(className);
  var questionAlternativeOrder  = [];
  for (int i = 0; i<questionAlternativeListHTML.length-1; i++ ) {
    placeHolderWidget.add(Text("Place Holder Widget"));
  }
  for (int i = 0; i< questionAlternativeListHTML.length-1; i++){
    questionAlternativeOrder.add(i);
  }
  questionAlternativeOrder = shuffle(questionAlternativeOrder);
  placeHolderWidget[questionAlternativeOrder[0]] = (rightAnswer(questionAlternativeOrder[0],Text(questionAlternativeListHTML[1].text), Colors.blue));
  for (int i = 2; i<questionAlternativeListHTML.length; i++) {
    var questionAlternativeText = Text(questionAlternativeListHTML[i].text);
    placeHolderWidget[questionAlternativeOrder[i-1]] = (wrongAnswer(questionAlternativeOrder[i-1],questionAlternativeText, Colors.blue));
  }
  var questionColumnLocal = <Widget>[Text(questionAlternativeListHTML[0].text),Column(
      children: placeHolderWidget
  )];
  return questionColumnLocal;
};