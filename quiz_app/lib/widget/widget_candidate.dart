import 'package:flutter/material.dart';

class CandWidget extends StatefulWidget {
  VoidCallback tap;
  String text;
  int index;
  double width;
  bool answerState;

  CandWidget(
      {required this.tap,
      required this.index,
      required this.width,
      required this.text,
      required this.answerState});
  @override
  _CandWidgetState createState() => _CandWidgetState();
}

class _CandWidgetState extends State<CandWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.8,
      height: widget.width * 0.1,
      padding: EdgeInsets.fromLTRB(
        widget.width * 0.048, // 글자 위치
        widget.width * 0.024,
        widget.width * 0.028,
        widget.width * 0.028,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color.fromARGB(255, 178, 137, 245),
        ),
        color: widget.answerState
            ? Color.fromARGB(255, 178, 137, 245)
            : Colors.white,
      ),
      child: InkWell(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.width * 0.035, //글자 사이즈
            fontFamily: 'NanumGothic',
            color: widget.answerState
                ? Color.fromARGB(255, 4, 14, 14)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        onTap: () {
          setState(() {
            widget.tap();
            widget.answerState = !widget.answerState;
          });
        },
      ),
    );
  }
}
