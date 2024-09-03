import 'dart:io';

void main() {
  bool isRunning = true;

  while (isRunning) {
    print("\n날짜 계산기");
    print("1. 두 날짜 간의 차이 계산");
    print("2. 날짜 더하기/빼기");
    print("3. 특정 날짜의 요일 확인");
    print("4. 종료");

    stdout.write("원하는 작업을 선택하세요: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        calculateDateDifference();
        break;

      case '2':
        addOrSubtractDays();
        break;

      case '3':
        checkDayOfWeek();
        break;

      case '4':
        print("프로그램을 종료합니다.");
        isRunning = false;
        break;

      default:
        print("잘못된 선택입니다. 다시 시도하세요.");
        break;
    }
  }
}

void calculateDateDifference() {
  stdout.write("첫 번째 날짜를 입력하세요 (YYYY-MM-DD): ");
  String? firstDateInput = stdin.readLineSync();
  stdout.write("두 번째 날짜를 입력하세요 (YYYY-MM-DD): ");
  String? secondDateInput = stdin.readLineSync();

  DateTime firstDate = DateTime.parse(firstDateInput!);
  DateTime secondDate = DateTime.parse(secondDateInput!);

  Duration difference = secondDate.difference(firstDate);
  print("두 날짜 간의 차이: ${difference.inDays}일");
}

void addOrSubtractDays() {
  stdout.write("기준 날짜를 입력하세요 (YYYY-MM-DD): ");
  String? baseDateInput = stdin.readLineSync();
  stdout.write("더하거나 뺄 일수를 입력하세요 (음수 입력 시 날짜를 뺍니다): ");
  String? daysInput = stdin.readLineSync();

  DateTime baseDate = DateTime.parse(baseDateInput!);
  int days = int.parse(daysInput!);

  DateTime newDate = baseDate.add(Duration(days: days));
  print("새로운 날짜: ${newDate.toLocal()}");
}

void checkDayOfWeek() {
  stdout.write("확인할 날짜를 입력하세요 (YYYY-MM-DD): ");
  String? dateInput = stdin.readLineSync();

  DateTime date = DateTime.parse(dateInput!);
  List<String> weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

  String dayOfWeek = weekdays[date.weekday - 1];
  print("${date.toLocal()}는 $dayOfWeek입니다.");
}
