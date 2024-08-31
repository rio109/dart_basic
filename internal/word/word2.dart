import 'dart:io';

class WordFrequencyCounter {
  final String text;

  WordFrequencyCounter(this.text);

  Map<String, int> calculateFrequency() {
    String sanitizedText =
        text.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
    List<String> words = sanitizedText.split(RegExp(r'\s+'));

    Map<String, int> wordFrequency = {};

    for (var word in words) {
      if (word.isNotEmpty) {
        wordFrequency[word] = (wordFrequency[word] ?? 0) + 1;
      }
    }

    return wordFrequency;
  }

  void displayFrequency() {
    var wordFrequency = calculateFrequency();
    if (wordFrequency.isEmpty) {
      print("is Empty");
      return;
    }

    var sortedEntries = wordFrequency.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value));

    // . 연산자는 cascade operator로, 객체에 여러 연산을 연달아 수행할 때 사용
    // (e1, e2) => e2.value.compareTo(e1.value) : 비교 함수 ,   e2 - e1 을 계산하고, e2가 더 크면  양수, 같으면 0 , 작으면 음수 반환

    print('\n 단어 빈도 수 :');
    for (var entry in sortedEntries) {
      print("${entry.key}: ${entry.value}");
    }
  }
}

void SameWordFiner2() {
  stdout.write("입력 값을 작성하세여 : ");
  String? input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    print("입력 값이 비어 있습니다");
    return;
  }

  var counter = WordFrequencyCounter(input);
  counter.displayFrequency();
}
