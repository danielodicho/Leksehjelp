import 'package:flutter/material.dart';
import "functions.dart";


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override

  Widget build(BuildContext context) {

    func = () {
      setState(() {

      });
    };
    var scoreShower = "Your score is $score out of $numQuestions";
    return Container(

        child: Scaffold(appBar: AppBar(
            title: Text("Question App")
        ),
          body: Column(children: [Text(scoreShower),Column(children: homo), Text(title),
            ElevatedButton(onPressed: () {
              setState(() {
                colorRight = Colors.blue;
                colorWrong = Colors.blue;
                answeredRight = true;
                title = "Can you get the question right?";
                if (counter<numQuestions-1)
                {
                  if (counter == 0) {
                    score = 0;
                  }
                  counter+=1;
                  idfk1 = "Next";
                  homo = questionsCreate("question${questionOrder[counter-1]}");
                }
                else if (counter<numQuestions) {counter+=1;

                homo = questionsCreate("question${questionOrder[counter-1]}");
                counter = 0;
                idfk1 = "Reset";
                func();
                }

              });
            }, child: Text(idfk1))],
          ),
        )
    );
  }
}
