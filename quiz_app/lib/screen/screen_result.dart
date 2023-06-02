import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/screen/screen_home.dart';

import '../model/model_quiz.dart';

class ResultScreen extends StatelessWidget {
  List<int> answers;
  List<Quiz> quizs;
  List<Quiz> chapter;
  ResultScreen(
      {required this.answers, required this.quizs, required this.chapter});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    List<String> chapter = [];
    int score = 0;
    for (int i = 0; i < quizs.length; i++) {
      if (quizs[i].answer == answers[i]) {
        score += 1;
      } else {
        chapter.add(quizs[i].chapter);
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('중등 수학 문제풀이'),
          backgroundColor: Color.fromARGB(255, 51, 67, 170),
          leading: Container(),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 68, 92, 230),
            ),
            width: width * 0.85,
            height: height * 0.5,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: width * 0.048),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color.fromARGB(255, 46, 67, 187)),
                    color: Colors.white,
                  ),
                  width: width * 0.73,
                  height: height * 0.25,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0, width * 0.048, 0, width * 0.012),
                        child: Text(
                          '수고하셨습니다!',
                          style: TextStyle(
                            fontSize: width * 0.055,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '당신의 점수는',
                        style: TextStyle(
                          fontSize: width * 0.048,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        '$score/${quizs.length}', //점수 표시
                        style: TextStyle(
                          fontSize: width * 0.20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(width * 0.042),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.022),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color.fromARGB(255, 46, 67, 187)),
                    color: Colors.white,
                  ),
                  width: width * 0.73,
                  height: height * 0.14,
                  padding: EdgeInsets.fromLTRB(
                      width * 0.012, width * 0.088, 0, width * 0.012),
                  child: Text(
                    'Chapter: ${chapter.join(', ')} 개념의 보충이 필요합니다.',
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Expanded(
                //   child: Text(
                //     'Chapter: ${chapter.join(', ')} 개념의 보충이 필요합니다.',
                //     style: TextStyle(
                //       fontSize: width * 0.048,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: width * 0.058),
                  child: ButtonTheme(
                    minWidth: width * 0.73,
                    height: height * 0.05,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }),
                        );
                      },
                      child: Text('홈으로 돌아가기'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
