import 'dart:io';

class Calculator {
  int first_number;
  int second_number;

  Calculator(this.first_number, this.second_number);

  int add() {
    return first_number + second_number;
  }

  int subtract() {
    return first_number - second_number;
  }

  int multiply() {
    return first_number * second_number;
  }

  double divide() {
    if (second_number != 0) {
      return first_number / second_number;
    } else {
      throw Exception("Cannot divide by zero");
    }
  }
}

void performCalculation() {
  try {
    stdout.write("Please enter the first number: ");
    String? firstInput = stdin.readLineSync();
    stdout.write("Please enter the second number: ");
    String? secondInput = stdin.readLineSync();
    stdout.write(
        "Please select the operation (1: add, 2: subtract, 3: multiply, 4: divide): ");
    String? operationInput = stdin.readLineSync();

    int firstNumber = int.parse(firstInput ?? '0');
    int secondNumber = int.parse(secondInput ?? '0');
    int operation = int.parse(operationInput ?? '0');

    var calculator = Calculator(firstNumber, secondNumber);

    switch (operation) {
      case 1:
        print("Result: ${calculator.add()}");
        break;
      case 2:
        print("Result: ${calculator.subtract()}");
        break;
      case 3:
        print("Result: ${calculator.multiply()}");
        break;
      case 4:
        print("Result: ${calculator.divide()}");
        break;
      default:
        print("Invalid operation selected.");
        break;
    }
  } catch (e) {
    print("Error Message : $e");
  }
}
