class WordModel {
  final String word;
  final String meaning;

  WordModel({
    required this.word,
    required this.meaning,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      word: json['word'] ?? '',
      meaning: json['meaning'] ?? '',
    );
  }
}