import 'dart:io';

class Question {
  String QuestionText;
  List<String> options;
  int correctAnswer;

  Question(this.QuestionText, this.options, this.correctAnswer);
}

class Quiz {
  List<Question> questions;
  int score = 0;
  int totalQuestions;
  int timeLimit;
  bool hintsAllowed;

  Quiz({
    required this.questions,
    required this.totalQuestions,
    required this.timeLimit,
    required this.hintsAllowed,
  });

  void start() {
    questions.shuffle();

    for (var i = 0; i < questions.length; i++) {
      var q = questions[i];

      print("\n ${i + 1}. 문제 : ${q.QuestionText}");

      for (var j = 0; j < q.options.length; j++) {
        print("\n ${j + 1}. ${q.options[j]}");
      }

      // if (hintsAllowed) {
      //   stdout.write("힌트를 원한다면 'hint' 입력하세요");
      // } else {
      //   stdout.write("정답 번호를 입력하세요");
      // }

      bool validAnswer = false;
      Stopwatch stopwatch = Stopwatch()..start();
      while (!validAnswer) {
        String? userInput = stdin.readLineSync();

        if (userInput == null) {
          print("invalid input data");
          continue;
        }

        if (userInput.toLowerCase() == 'hint' && hintsAllowed) {}
        ;

        int? userAnswerIndex = int.tryParse(userInput);
        if (userAnswerIndex == null ||
            userAnswerIndex < 1 ||
            userAnswerIndex > q.options.length) {
          print("invalid opeion number");
        } else {
          validAnswer = true;
          if (userAnswerIndex == q.correctAnswer) {
            print("this is correct");
            score++;
          } else {
            print("is not correct");
          }
        }

        stopwatch.stop();
        if (stopwatch.elapsed.inSeconds > timeLimit) {
          print("time over");
          break;
        }
      }
    }
    print("\n quiz is done , your score is $score/${totalQuestions}");
  }

  void provideHint(Question q) {
    // 선택지에서 정답이 아닌 것을 제거 (랜덤하게 한 개만 제거)
    List<int> wrongAnswers = List.generate(q.options.length, (i) => i + 1)
      ..remove(q.correctAnswer);
    wrongAnswers.shuffle();
    print("hint : ${wrongAnswers.first}번 선택지가 제거 되었습니다");
  }
}

void testQuiz2() {
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
    Question(
      "세계에서 가장 작은 대륙은?",
      ["남극", "유럽", "오세아니아", "북아메리카"],
      3,
    ),
    Question(
      "Dart의 창시자는?",
      ["Google", "Facebook", "Microsoft", "Apple"],
      1,
    ),
  ];

  print("퀴즈 게임에 오신 것을 환영합니다!");

  stdout.write("난이도를 선택하세요 (1: 쉬움, 2: 보통, 3: 어려움): ");
  String? difficultyInput = stdin.readLineSync();
  int difficulty = int.tryParse(difficultyInput ?? '2') ?? 2;

  int totalQuestions;
  int timeLimit;
  bool hintsAllowed;

  switch (difficulty) {
    case 1:
      totalQuestions = 3;
      timeLimit = 20;
      hintsAllowed = true;
      break;
    case 2:
      totalQuestions = 4;
      timeLimit = 15;
      hintsAllowed = false;
      break;
    case 3:
      totalQuestions = 5;
      timeLimit = 10;
      hintsAllowed = false;
      break;
    default:
      totalQuestions = 4;
      timeLimit = 15;
      hintsAllowed = false;
      break;
  }

  var quiz = Quiz(
    questions: questions,
    totalQuestions: totalQuestions,
    timeLimit: timeLimit,
    hintsAllowed: hintsAllowed,
  );

  quiz.start();
}
