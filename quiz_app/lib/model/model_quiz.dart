class Quiz {
  String title;
  List<String> candidates;
  int answer;

  String chapter;

  Quiz(
      {required this.title,
      required this.candidates,
      required this.answer,
      required this.chapter});

  // Quiz.fromMap(Map<String, dynamic> map)
  //     : title = map['title'] ?? '',
  //       candidates = List<String>.from(map['candidates'] ?? []),
  //       answer = map['answer'] ?? 0;

  Quiz.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        candidates = json['body'].toString().split('/'),
        answer = json['answer'],
        chapter = json['chapter'];
}
