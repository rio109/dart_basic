import 'dart:io';

class Calculator2 {
  int firstNumber;
  int secondNumber;

  Calculator2(this.firstNumber, this.secondNumber);

  int add() => firstNumber + secondNumber;

  int subtract() => firstNumber - secondNumber;

  int multiply() => firstNumber * secondNumber;

  double divide() {
    if (secondNumber != 0) {
      return firstNumber / secondNumber;
    } else {
      throw Exception("Cannot divide by zero");
    }
  }
}

void displayMenu() {
  print("\n계산기를 사용하실 수 있습니다.");
  print("1: 덧셈");
  print("2: 뺄셈");
  print("3: 곱셈");
  print("4: 나눗셈");
  print("5: 종료");
}

int getIntInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? intput = stdin.readLineSync();
    try {
      return int.parse(intput!);
    } catch (e) {
      print("invalid input datas");
    }
  }
}

void performCalculation2() {
  while (true) {
    displayMenu();
    int choice = getIntInput("원하는 작업을 선택하세요 (1-5): ");

    if (choice == 5) {
      print("계산기를 종료합니다.");
      break;
    }

    int firstNumber = getIntInput("첫 번째 숫자를 입력하세요: ");
    int secondNumber = getIntInput("두 번째 숫자를 입력하세요: ");

    var calculator = Calculator2(firstNumber, secondNumber);

    try {
      switch (choice) {
        case 1:
          print("덧셈 결과: ${calculator.add()}");
          break;
        case 2:
          print("뺄셈 결과: ${calculator.subtract()}");
          break;
        case 3:
          print("곱셈 결과: ${calculator.multiply()}");
          break;
        case 4:
          print("나눗셈 결과: ${calculator.divide()}");
          break;
        default:
          print("잘못된 선택입니다. 다시 시도해주세요.");
          break;
      }
    } catch (e) {
      print("오류: $e");
    }
  }
}
