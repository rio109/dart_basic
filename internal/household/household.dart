import 'dart:io';

class Transaction {
  String type;
  double amount;
  String description;
  DateTime date;

  Transaction(this.type, this.amount, this.description, this.date);
}

class TimeData {
  DateTime start;
  DateTime end;

  TimeData(this.start, this.end);
}

class AccountBook {
  List<Transaction> transactions = [];

  void addTransaction(Transaction t) {
    var transaction = t;
    transactions.add(transaction);
    print("내역이 추가되었습니다. : ${t.type} - ${t.amount}");
  }

  void viewAllTransactions() {
    if (transactions.isEmpty) {
      print("data is empty");
      return;
    }

    print("\n 모든 거래 내약");
    for (var transaction in transactions) {
      print(
          "${transaction.date}: ${transaction.type} - ${transaction.amount} - ${transaction.description}");
    }
  }

  double getBalance() {
    double balance = 0;
    for (var t in transactions) {
      if (t.type == 'income') {
        balance += t.amount;
      } else if (t.type == 'expense') {
        balance -= t.amount;
      }
    }
    return balance;
  }

  void viewBalance() {
    double balance = getBalance();
    print("현재 잔액 : ${balance} 원");
  }

  void viewSummary(TimeData d) {
    double income = 0;
    double expense = 0;

    for (var t in transactions) {
      if (t.date.isAfter(d.start) && t.date.isBefore(d.end)) {
        if (t.type == 'income') {
          income += t.amount;
        } else if (t.type == 'expense') {
          expense += t.amount;
        }
      }
    }

    print("\n기간별 요약 (${d.start} ~ ${d.end}):");
    print("총 수입: $income 원");
    print("총 지출: $expense 원");
    print("순 수익: ${income - expense} 원");
  }
}

void testHouseHold() {
  var accountBook = AccountBook();
  bool isRunning = true;

  while (isRunning) {
    print("\n가계부 프로그램");
    print("1. 수입 추가");
    print("2. 지출 추가");
    print("3. 거래 내역 조회");
    print("4. 잔액 조회");
    print("5. 기간별 요약 조회");
    print("6. 종료");

    stdout.write("원하는 작업을 선택하세요: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("수입 금액을 입력하세요: ");
        String? incomeInput = stdin.readLineSync();
        double income = double.tryParse(incomeInput ?? '0') ?? 0;

        stdout.write("수입 설명을 입력하세요: ");
        String? incomeDescription = stdin.readLineSync();

        accountBook.addTransaction(Transaction(
            'income', income, incomeDescription ?? '수입', DateTime.now()));
        break;

      case '2':
        stdout.write("지출 금액을 입력하세요: ");
        String? expenseInput = stdin.readLineSync();
        double expense = double.tryParse(expenseInput ?? '0') ?? 0;

        stdout.write("지출 설명을 입력하세요: ");
        String? expenseDescription = stdin.readLineSync();

        accountBook.addTransaction(Transaction(
            'expense', expense, expenseDescription ?? '지출', DateTime.now()));
        break;

      case '3':
        accountBook.viewAllTransactions();
        break;

      case '4':
        accountBook.viewBalance();
        break;

      case '5':
        stdout.write("시작 날짜 (YYYY-MM-DD) 입력하세요: ");
        String? startDateInput = stdin.readLineSync();
        stdout.write("종료 날짜 (YYYY-MM-DD) 입력하세요: ");
        String? endDateInput = stdin.readLineSync();

        DateTime startDate =
            DateTime.parse(startDateInput ?? DateTime.now().toString());
        DateTime endDate =
            DateTime.parse(endDateInput ?? DateTime.now().toString());

        accountBook.viewSummary(TimeData(startDate, endDate));
        break;

      case '6':
        print("프로그램을 종료합니다.");
        isRunning = false;
        break;

      default:
        print("잘못된 선택입니다. 다시 시도하세요.");
        break;
    }
  }
}
