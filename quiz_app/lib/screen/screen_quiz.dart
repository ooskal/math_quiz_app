import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:quiz/model/model_quiz.dart';
import 'package:quiz/screen/screen_result.dart';

import '../widget/widget_candidate.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;

  QuizScreen({required this.quizs});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> _answers = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]; //퀴즈 갯수
  List<bool> _answersState = [false, false, false, false];
  int _currentIndex = 0;
  SwiperController _controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 161, 200, 226),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color.fromARGB(255, 161, 200, 226))),
            width: width * 0.85,
            height: height * 0.5,
            child: Swiper(
              controller: _controller, //swiper 위젯의 컨트롤러를 설정
              physics: NeverScrollableScrollPhysics(), // 스와이프 동작을 비활성화
              loop: false, // 스와이프 반복을 비활성화
              itemCount: widget.quizs.length, //퀴즈 개수를 항목 수로 설정
              itemBuilder: (BuildContext context, int index) {
                //함수를 호출하여 퀴즈 카드 생성
                return _buildquizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildquizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white),
      child: Column(
        // 자식 위젯을 세로로 배열
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //퀴즈 번호를 표시하기 위한 컨테이너
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q${_currentIndex + 1}', // 퀴즈번호 표시
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //퀴즈 제목 표시하기 위한 컨테이너
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontSize: width * 0.048, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(), // 다음 위젯을 아래로 밀어내기 위한 공간 확보
          ),
          Column(
            children:
                _buildCandidates(width, quiz), // 선택지를 표시하는 위젯들을 자식 위젯으로 포함
          ),
          //버튼을 위한 컨테이너
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  // 현재 퀴즈 인덱스에 따라 버튼 텍스트를 다르게 표시함
                  child: _currentIndex == widget.quizs.length - 1
                      ? Text("결과보기") //결과보기
                      : Text('다음문제'), // 다음문제
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 161, 200, 226),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  onPressed: _answers[_currentIndex] == -1
                      ? null // 선택한 답변이 없으면 버튼 비활성화
                      : () {
                          if (_currentIndex == widget.quizs.length - 1) {
                            // 마지막 퀴즈인 경우 결과 화면으로 이동
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          answers: _answers,
                                          quizs: widget.quizs,
                                          chapter: widget.quizs, // chapter 값 전달
                                        )));
                          } else {
                            // 그렇지 않으면 상태를 업데이트 하고 다음 퀴즈로 이동
                            _answersState = [false, false, false, false];
                            _currentIndex += 1;
                            _controller.next();
                          }
                        },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4개의 답 항목 위젯
  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answersState[i],
          tap: () {
            setState(() {
              // 후보 항목이 탭되었을 때의 동작을 정의
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  //탭된 후보 항목에 대한 상태를 업뎃
                  _answersState[i] = true;
                  _answers[_currentIndex] = j;
                } else {
                  // 탭되지 않은 후보 항목의 상태를 업뎃
                  _answersState[j] = false;
                }
              }
            });
          },
        ),
      );

      //후보 항목 사이에 여백 추가
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }
    return _children;
  }
}
