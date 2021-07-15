import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import "functions.dart";

var listOfQuizzes = "quiz_list";
var quizListDocument;
var addButtons;
var addArticleButtons;
var quizButtons = <Widget>[];
var quizListDocumentTagNameH;
var quizListDocumentClassNameArticle;
var subjectListDocument;
var loadQuizPage;
var subjectList = <Widget>[];
var loadArticle;
var articleTextList = <Widget>[];
var articleTitle;

var quizNamePublic;


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => SubjectListPage(),
        "Subject Content": (context) => SubjectContentPage(),
        "Quiz Page": (context) => QuizPage(),
        "QuizResultPage": (context) => QuizResultPage(),
        "articlePage": (context) => ArticlePage(),
      },
    );
  }
}


class SubjectListPage extends StatefulWidget {
  @override
  _SubjectListPageState createState() => _SubjectListPageState();
}

class _SubjectListPageState extends State<SubjectListPage> {
  @override
  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState() {
    var subjectListCreateButtonsColumn = () {
      var tempSubjectList = <Widget>[];
      var subjectListHeaders = subjectListDocument.getElementsByTagName("h");
      for (var i = 0; i < subjectListHeaders!.length; i++) {
        var subject = subjectListHeaders[i];
        var tempText = subject.text;
        var tempWidget = ElevatedButton(
            onPressed: () {
              setState(() {
                listOfQuizzes = tempText!;
                Navigator.pushNamed(context, "Subject Content");
              });
            },
            child: Text(tempText!));
        tempSubjectList.add(tempWidget);
        return tempSubjectList;
      }
      ;
    };
    subjectList = subjectListCreateButtonsColumn() as List<Widget>;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Courses")),
        body: Column(children: subjectList));
  }
}

class SubjectContentPage extends StatefulWidget {
  @override
  _SubjectContentPageState createState() => _SubjectContentPageState();
}

class _SubjectContentPageState extends State<SubjectContentPage> {
  @override
  @protected
  @mustCallSuper
  void initState() {
    quizButtons = [];
    addButtons = (quizName) {
      var linkToQuizButton;
      linkToQuizButton = ElevatedButton(
          onPressed: () async {
            reset();
            await loadQuestions(quizName);
            quizNamePublic = quizName;
            Navigator.pushNamed(context, "Quiz Page");
          },
          child: Text(quizName));
      quizButtons.add(linkToQuizButton);
    };
    addArticleButtons = (articleName) {
      articleTextList = <Widget>[];
      var linkToArticleButton;
      linkToArticleButton = ElevatedButton(
          onPressed: () async {
            articleTitle = articleName;
            articleTextList = <Widget>[];
            reset();
            var articleDocument = await Chaleno().load(
                "https://donekun.github.io/quiz-test/${articleName.replaceAll(" ", "_")}");
            var articleDocumentHeaderList =
            articleDocument!.getElementsByTagName("h");

            for (var articleHeaderItem in articleDocumentHeaderList!) {
              if (articleHeaderItem.src == null) {
                if ([
                  for (var tempArticleItemClassBold
                  in articleDocument.getElementsByClassName("bold"))
                    tempArticleItemClassBold.text
                ].contains(articleHeaderItem.text)) {
                  articleTextList.add(Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        articleHeaderItem.text.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: 25),
                      )));
                } else {
                  articleTextList.add(Container(
                      margin: EdgeInsets.all(20),
                      child: Text(articleHeaderItem.text.toString())));
                }
              } else if (YoutubePlayerController.convertUrlToId(
                  articleHeaderItem.src.toString()) ==
                  null) {
                articleTextList.add(Container(
                    margin: EdgeInsets.all(20),
                    child: Image.network(articleHeaderItem.src.toString())));
              } else {
                var articleVideoYoutubeID =
                YoutubePlayerController.convertUrlToId(
                    articleHeaderItem.src.toString());
                // ignore: close_sinks
                YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId: articleVideoYoutubeID.toString(),
                  params: YoutubePlayerParams(
                    showFullscreenButton: true,
                    showControls: true,
                    autoPlay: false,

                  ),
                );
                articleTextList.add(
                  Container(
                    margin: EdgeInsets.all(20),
                    child: YoutubePlayerIFrame(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                );
              }
            }
            Navigator.pushNamed(context, "articlePage");
          },
          child: Text(articleName));
      quizButtons.add(linkToArticleButton);
    };
    loadQuizPage = (quizList) async {
      quizListDocument = await Chaleno().load(
          'https://donekun.github.io/quiz-test/${quizList.replaceAll(" ", "_")}');
      quizListDocumentTagNameH = quizListDocument.getElementsByTagName("h");
      quizListDocumentClassNameArticle =
          quizListDocument.getElementsByClassName("article");
      var quizListClassNameArticle = [
        for (var element in quizListDocumentClassNameArticle) element.text
      ];
      for (var items in quizListDocumentTagNameH) {
        if (quizListClassNameArticle.contains(items.text)) {
          addArticleButtons(items.text);
        } else {
          addButtons(items.text);
        }
      }
      setState(() {});
    };

    loadQuizPage(listOfQuizzes);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(listOfQuizzes)),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(children: quizButtons),
        ),
      ),
    );
  }
}


class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    quizPageSetState = () {
      setState(() {});
    };
    var scoreShower = "Your score is $score out of $numQuestions";
    return Container(
        child: Scaffold(
      appBar: AppBar(title: Text(quizNamePublic)),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text(scoreShower),
              Column(children: questionColumn),
              Text(title),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      answeredRight = true;
                      title = "Can you get the question right?";
                      if (counter < numQuestions - 1) {
                        if (counter == 0) {
                          Navigator.pushReplacementNamed(
                              context, "QuizResultPage");
                        }
                        counter += 1;
                        nextButtonString = "Next";
                        questionColumn = questionsCreate(
                            "question${questionOrder[counter - 1]}");
                      } else if (counter < numQuestions) {
                        counter += 1;

                        questionColumn = questionsCreate(
                            "question${questionOrder[counter - 1]}");
                        counter = 0;
                        nextButtonString = "Finish";
                        quizPageSetState();
                      }
                    });
                  },
                  child: Text(nextButtonString))
            ],
          ),
        ),
      ),
    ));
  }
}

// ignore: top_level_function_literal_block
var reset = () {
  answeredRight = true;
  title = "Can you get the question right?";
  score = 0;
  counter = 1;
  nextButtonString = "Next";
};





// ignore: top_level_function_literal_block
class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(articleTitle),
        ),
        body: SingleChildScrollView(child: Column(children: articleTextList)));
  }
}

class QuizResultPage extends StatefulWidget {
  @override
  _QuizResultPageState createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Result Page")),
      body: Center(
          child: Column(
        children: [
          Text("Your score is $score out of $numQuestions"),
          ElevatedButton(
              onPressed: () {
                questionOrder = shuffle(questionOrder);

                score = 0;
                counter = 1;
                Navigator.pushReplacementNamed(context, "Quiz Page");
              },
              child: Text("Start again")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Return"))
        ],
      )),
    );
  }
}
