import 'package:flutter/material.dart';
import 'dart:math';
import 'package:chaleno/chaleno.dart';

var score = 0;
var answeredRight  = true;
void changeHomo;
var counter = 1;
var idfk1 = "Next";
var numQuestions = 3;
// ignore: top_level_function_literal_block
var func;
var homo;
var fuckshitup = <Widget>[];
var questionDocument;
var colorRight = Colors.blue;
var colorWrong = Colors.blue;
var title = "Can you get the question right?";

var questionOrder = [];
var start = () async {
  numQuestions = 3;
  for (int i = 1; i<=numQuestions; i++ ) {
    // ignore: unnecessary_statements
    questionOrder.add(i);
  }

  questionOrder = shuffle(questionOrder);
  print(questionOrder);
  questionDocument = await Chaleno().load('https://donekun.github.io/quiz-test/');
  homo = questionsCreate("question${questionOrder[0]}");
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
var wrongAnswer = (index,nah,wrongColor) {
  return Container(
      child: ElevatedButton(child: nah, onPressed: () {
//colorRight = Colors.green;
        title = "Hahaha you dumb as fuck";
        print(homo);
        answeredRight = false;
        fuckshitup[index] = wrongAnswer(index,nah, Colors.red);
        homo[1] = Column(children: fuckshitup);
        print(123123123);
        print(nah);
        func();
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
        fuckshitup[index] = rightAnswer(index,nah, Colors.green);
        homo[1] = Column(children: fuckshitup);
        print(index);
        print(nah);
        func();
      },style: ElevatedButton.styleFrom(primary: rightColor) ),
      margin: EdgeInsets.all(10)
  );
};

// ignore: non_constant_identifier_names, top_level_function_literal_block
var questionsCreate = (className) {
  fuckshitup = <Widget>[];
  var dick = questionDocument.getElementsByClassName(className);
  var cock  = [];
  for (int i = 0; i<dick.length-1; i++ ) {
    fuckshitup.add(Text("213123"));
  }
  for (int i = 0; i< dick.length-1; i++){
    cock.add(i);
  }
  cock = shuffle(cock);
  fuckshitup[cock[0]] = (rightAnswer(cock[0],Text(dick[1].text), Colors.blue));
  for (int i = 2; i<dick.length; i++) {
    var nah = Text(dick[i].text);
    fuckshitup[cock[i-1]] = (wrongAnswer(cock[i-1],nah, Colors.blue));
  }
  var homo = <Widget>[Text(dick[0].text),Column(
      children: fuckshitup
  )];
  return homo;
};