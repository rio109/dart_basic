
```dart


// 생성자를 사용할 경우

class Calculater {
  int first_number;
  int second_number;

    // 생성자 : 클래스의 인스턴스를 생성할 때 호출되는 메서드
  Calculater(this.first_number, this.second_number);
}

class Calculater {
  int first_number;
  int second_number;

    // 생성자 : 클래스의 인스턴스를 생성할 때 호출되는 메서드
  Calculater(this.first_number, this.second_number);
}

void main() {
  var calc = Calculator(10, 20);
  print(calc.first_number); // 출력: 10
  print(calc.second_number); // 출력: 20
}


// 생성자를 사용하지 않을 경우

class Calculater {
  late int first_number;
  late int second_number;
}

void main() {
  var calc = Calculator();
  calc.first_number = 10;
  calc.second_number = 20;
  print(calc.first_number); // 출력: 10
  print(calc.second_number); // 출력: 20
}

```