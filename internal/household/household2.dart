import 'dart:io';
import 'dart:convert'; // JSON 인코딩 및 디코딩을 위해 사용

// 거래 내역을 나타내는 클래스
class Transaction {
  String type; // 거래 유형: 'income' 또는 'expense'
  double amount; // 거래 금액
  String description; // 거래 설명
  String category; // 거래 카테고리
  DateTime date; // 거래 날짜

  // 생성자
  Transaction(
      this.type, this.amount, this.description, this.category, this.date);

  // 객체를 JSON 형식으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date.toIso8601String(), // 날짜를 ISO 8601 형식의 문자열로 변환
    };
  }

  // JSON 데이터를 객체로 변환하는 정적 메서드
  static Transaction fromJson(Map<String, dynamic> json) {
    return Transaction(
      json['type'], // JSON에서 'type'을 가져와서 할당
      json['amount'], // JSON에서 'amount'를 가져와서 할당
      json['description'], // JSON에서 'description'을 가져와서 할당
      json['category'], // JSON에서 'category'를 가져와서 할당
      DateTime.parse(json['date']), // JSON에서 'date'를 가져와 DateTime으로 변환
    );
  }
}

// 가계부를 관리하는 클래스
class AccountBook {
  List<Transaction> transactions = []; // 거래 내역을 저장하는 리스트

  // 거래를 추가하는 메서드
  void addTransaction(
      String type, double amount, String description, String category) {
    var transaction =
        Transaction(type, amount, description, category, DateTime.now());
    transactions.add(transaction); // 새 거래를 리스트에 추가
    print(
        "거래가 추가되었습니다: ${transaction.type} - ${transaction.amount} - ${transaction.description} - ${transaction.category}");
  }

  // 모든 거래 내역을 출력하는 메서드
  void viewAllTransactions() {
    if (transactions.isEmpty) {
      // 거래가 없으면
      print("거래 내역이 없습니다.");
      return;
    }

    print("\n모든 거래 내역:");
    for (var transaction in transactions) {
      // 각 거래를 출력
      print(
          "${transaction.date}: ${transaction.type} - ${transaction.amount} - ${transaction.description} - ${transaction.category}");
    }
  }

  // 현재 잔액을 계산하는 메서드
  double getBalance() {
    double balance = 0; // 초기 잔액은 0
    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        balance += transaction.amount; // 수입이면 잔액에 더함
      } else if (transaction.type == 'expense') {
        balance -= transaction.amount; // 지출이면 잔액에서 뺌
      }
    }
    return balance; // 최종 잔액 반환
  }

  // 현재 잔액을 출력하는 메서드
  void viewBalance() {
    double balance = getBalance();
    print("현재 잔액: $balance 원");
  }

  // 특정 기간의 거래 요약을 출력하는 메서드
  void viewSummary(DateTime startDate, DateTime endDate) {
    double income = 0; // 기간 내 수입 총합
    double expense = 0; // 기간 내 지출 총합

    for (var transaction in transactions) {
      // 거래 날짜가 주어진 기간에 해당하면
      if (transaction.date.isAfter(startDate) &&
          transaction.date.isBefore(endDate)) {
        if (transaction.type == 'income') {
          income += transaction.amount; // 수입이면 수입 총합에 더함
        } else if (transaction.type == 'expense') {
          expense += transaction.amount; // 지출이면 지출 총합에 더함
        }
      }
    }

    print("\n기간별 요약 ($startDate ~ $endDate):");
    print("총 수입: $income 원");
    print("총 지출: $expense 원");
    print("순 수익: ${income - expense} 원");
  }

  // 거래 데이터를 파일에 저장하는 메서드
  void saveToFile(String filePath) {
    var file = File(filePath); // 파일 객체 생성
    var jsonList =
        transactions.map((t) => t.toJson()).toList(); // 거래 리스트를 JSON으로 변환
    file.writeAsStringSync(jsonEncode(jsonList)); // JSON 데이터를 파일에 저장
    print("데이터가 파일에 저장되었습니다: $filePath");
  }

  void saveToFile2(String filePath) {
    var file = File(filePath); // 파일 객체 생성
    var jsonList = [];
    transactions.forEach((t) {
      jsonList.add(t.toJson());
    });
    file.writeAsStringSync(jsonEncode(jsonList)); // JSON 데이터를 파일에 저장
    print("데이터가 파일에 저장되었습니다: $filePath");
  }

  void saveToFile3(String filePath) {
    var file = File(filePath); // 파일 객체 생성
    var jsonList = [];
    for (var t in transactions) {
      jsonList.add(t.toJson());
    }
    file.writeAsStringSync(jsonEncode(jsonList)); // JSON 데이터를 파일에 저장
    print("데이터가 파일에 저장되었습니다: $filePath");
  }

  void saveToFile4(String filePath) {
    var file = File(filePath); // 파일 객체 생성
    var jsonList = [for (var t in transactions) t.toJson()];
    file.writeAsStringSync(jsonEncode(jsonList)); // JSON 데이터를 파일에 저장
    print("데이터가 파일에 저장되었습니다: $filePath");
  }

  // 파일에서 거래 데이터를 불러오는 메서드
  void loadFromFile(String filePath) {
    var file = File(filePath);
    if (file.existsSync()) {
      // 파일이 존재하면
      var jsonString = file.readAsStringSync(); // 파일 내용을 문자열로 읽음
      var jsonList = jsonDecode(jsonString) as List; // JSON 문자열을 리스트로 디코딩
      transactions = jsonList
          .map((json) => Transaction.fromJson(json))
          .toList(); // 리스트를 거래 객체 리스트로 변환
      print("데이터가 파일에서 불러와졌습니다: $filePath");
    } else {
      print("파일이 존재하지 않습니다: $filePath");
    }
  }
}

// 프로그램 실행의 진입점
void household2() {
  var accountBook = AccountBook(); // AccountBook 객체 생성
  bool isRunning = true; // 프로그램이 실행 중인지 여부

  while (isRunning) {
    // 사용자에게 메뉴를 보여줌
    print("\n가계부 프로그램");
    print("1. 수입 추가");
    print("2. 지출 추가");
    print("3. 거래 내역 조회");
    print("4. 잔액 조회");
    print("5. 기간별 요약 조회");
    print("6. 데이터 저장");
    print("7. 데이터 불러오기");
    print("8. 종료");

    stdout.write("원하는 작업을 선택하세요: ");
    String? choice = stdin.readLineSync(); // 사용자로부터 입력 받음

    switch (choice) {
      case '1': // 수입 추가
        stdout.write("수입 금액을 입력하세요: ");
        String? incomeInput = stdin.readLineSync();
        double income =
            double.tryParse(incomeInput ?? '0') ?? 0; // 입력된 수입 금액을 double로 변환

        stdout.write("수입 설명을 입력하세요: ");
        String? incomeDescription = stdin.readLineSync();

        stdout.write("카테고리를 입력하세요: ");
        String? category = stdin.readLineSync();

        accountBook.addTransaction(
            'income', income, incomeDescription ?? '수입', category ?? '기타');
        break;

      case '2': // 지출 추가
        stdout.write("지출 금액을 입력하세요: ");
        String? expenseInput = stdin.readLineSync();
        double expense =
            double.tryParse(expenseInput ?? '0') ?? 0; // 입력된 지출 금액을 double로 변환

        stdout.write("지출 설명을 입력하세요: ");
        String? expenseDescription = stdin.readLineSync();

        stdout.write("카테고리를 입력하세요: ");
        String? category = stdin.readLineSync();

        accountBook.addTransaction(
            'expense', expense, expenseDescription ?? '지출', category ?? '기타');
        break;

      case '3': // 거래 내역 조회
        accountBook.viewAllTransactions();
        break;

      case '4': // 잔액 조회
        accountBook.viewBalance();
        break;

      case '5': // 기간별 요약 조회
        stdout.write("시작 날짜 (YYYY-MM-DD) 입력하세요: ");
        String? startDateInput = stdin.readLineSync();
        stdout.write("종료 날짜 (YYYY-MM-DD) 입력하세요: ");
        String? endDateInput = stdin.readLineSync();

        DateTime startDate = DateTime.parse(startDateInput ??
            DateTime.now().toString()); // 시작 날짜를 DateTime으로 변환
        DateTime endDate = DateTime.parse(
            endDateInput ?? DateTime.now().toString()); // 종료 날짜를 DateTime으로 변환

        accountBook.viewSummary(startDate, endDate);
        break;

      case '6': // 데이터 저장
        stdout.write("저장할 파일 경로를 입력하세요: ");
        String? filePath = stdin.readLineSync();
        accountBook
            .saveToFile(filePath ?? 'account_book.json'); // 파일 경로가 없으면 기본 경로 사용
        break;

      case '7': // 데이터 불러오기
        stdout.write("불러올 파일 경로를 입력하세요: ");
        String? filePath = stdin.readLineSync();
        accountBook.loadFromFile(
            filePath ?? 'account_book.json'); // 파일 경로가 없으면 기본 경로 사용
        break;

      case '8': // 프로그램 종료
        print("프로그램을 종료합니다.");
        isRunning = false; // while 루프 종료
        break;

      default: // 잘못된 입력 처리
        print("잘못된 선택입니다. 다시 시도하세요.");
        break;
    }
  }
}
