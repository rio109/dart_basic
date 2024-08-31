import 'dart:io';

void SameWordFiner() {
  stdout.write("press input data : ");
  String? input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    print("invalid data or data is empty");
    return;
  }

  List<String> words = input.toLowerCase().split(RegExp(r'\s+'));

  Map<String, int> wordFrequency = {};

  for (var word in words) {
    if (wordFrequency.containsKey(word)) {
      wordFrequency[word] = wordFrequency[word]! + 1;
    } else {
      wordFrequency[word] = 1;
    }
  }
  print("\n 빈도수 : ");

  wordFrequency.forEach((word, count) {
    print("$word : $count");
  });
}
