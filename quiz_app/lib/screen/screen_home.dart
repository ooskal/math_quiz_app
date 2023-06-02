import 'package:flutter/material.dart';
import 'package:quiz/model/api_adapter.dart';
import 'package:quiz/model/model_quiz.dart';
import 'package:quiz/screen/screen_quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quiz> quizs = [];
  bool isLoading = false;

  _fetchQuizs() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse('http://localhost:8000/quiz/10/'));
    if (response.statusCode == 200) {
      String responseData = response.body;
      print(responseData); // 데이터 값 콘솔에 출력

      quizs = parseQuizs(utf8.decode(response.bodyBytes));
      isLoading = false;
    } else {
      throw Exception('failed to load data');
    }
  }
  // List<Quiz> quizs = [
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  // ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("중등 문제 풀기 앱"),
          backgroundColor: Color.fromARGB(255, 112, 176, 212),
          leading: Container(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            Text(
              '중등 문제 풀기 앱',
              style: TextStyle(
                fontSize: width * 0.065,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.048),
            ),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.036),
              child: Center(
                child: ButtonTheme(
                  minWidth: width * 0.8,
                  height: height * 0.05,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _fetchQuizs().whenComplete(() {
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              quizs: quizs,
                            ),
                          ),
                        );
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            quizs: quizs,
                          ),
                        ),
                      );
                      // 버튼 클릭 시 동작할 내용 추가
                    },
                    child: Text("문제풀기"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
