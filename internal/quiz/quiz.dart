import 'dart:io';

class Question {
  String questionText;
  List<String> options;
  int correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}

class Quiz {
  List<Question> questions;
  int score = 0;

  Quiz(this.questions);

  void start() {
    for (var i = 0; i < questions.length; i++) {
      var q = questions[i];
      print("\n 문제 : ${i + 1}: ${q.questionText}");

      for (var j = 0; j < q.options.length; j++) {
        print("\n ${j + 1}. ${q.options[j]}");
      }

      stdout.write("정답 번호를 입력하세요");
      String? userAnswer = stdin.readLineSync();
      int userAnswerIndex = int.tryParse(userAnswer ?? '') ?? 0;

      if (userAnswerIndex == q.correctAnswer) {
        print("정답입니다.");
        score++;
      } else {
        print("오답입니다. 정답은 ${q.correctAnswer}번 입니다.");
      }
    }

    print("\n 문제종료 당신의 점수는 $score/${questions.length} 입니다.");
  }
}

void testQuiz() {
  var questions = [
    Question(
      "다음 중 대한민국의 수도는?",
      ["서울", "부산", "인천", "대구"],
      1,
    ),
    Question(
      "세계에서 가장 큰 대륙은?",
      ["아시아", "아프리카", "유럽", "남극"],
      1,
    ),
    Question(
      "컴퓨터 프로그래밍 언어 중 하나는?",
      ["HTML", "Dart", "CSS", "SQL"],
      2,
    ),
  ];

  var quiz = Quiz(questions);
  quiz.start();
}
